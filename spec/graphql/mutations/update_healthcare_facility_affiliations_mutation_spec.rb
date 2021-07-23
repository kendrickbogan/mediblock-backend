# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateHealthcareFacilityAffiliationsMutation do
  context "with a valid request" do
    context "with required arguments" do
      it "updates and returns the list of affiliations" do
        person = create(:person)

        affiliation_attrs = OpenStruct.new(
          {
            facility_name: "Healthcare Facility",
            privilege_limitations: false,
            membership_status: "ACTIVE",
            started_at: 5.years.ago
          }
        )

        arguments = [affiliation_attrs]

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateHealthcareFacilityAffiliations")
          .fetch("healthcareFacilityAffiliations")
          .fetch(0)
        healthcare_facility_affiliations = person.healthcare_facility_affiliations

        expect(healthcare_facility_affiliations.length).to eq 1
        expect(data["facilityName"]).to eq affiliation_attrs.facility_name
        expect(data["privilegeLimitations"]).to eq affiliation_attrs.privilege_limitations
        expect(data["membershipStatus"]).to eq affiliation_attrs.membership_status
        expect(data["startedAt"]).to eq affiliation_attrs.started_at.iso8601
      end

      it "can create multiple records" do
        person = create(:person)

        affiliation_1 = OpenStruct.new(
          {
            facility_name: "Healthcare Facility",
            privilege_limitations: false,
            membership_status: "ACTIVE",
            started_at: 5.years.ago
          }
        )
        affiliation_2 = OpenStruct.new(
          {
            facility_name: "Another Healthcare Facility",
            privilege_limitations: false,
            membership_status: "ACTIVE",
            started_at: 6.years.ago
          }
        )

        arguments = [affiliation_1, affiliation_2]

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateHealthcareFacilityAffiliations")

        healthcare_facility_affiliations = person.healthcare_facility_affiliations
        facility_names = data["healthcareFacilityAffiliations"].map { |affiliation| affiliation["facilityName"] }

        expect(healthcare_facility_affiliations.length).to eq 2
        expect(facility_names).to match_array [affiliation_1.facility_name, affiliation_2.facility_name]
      end
    end
  end

  context "when a user is not signed in" do
    it "returns an authentication error" do
      affiliation_attrs = OpenStruct.new(
        {
          facility_name: "Healthcare Facility",
          facility_type: "Skilled Nursing",
          department_or_division_name: "Medical",
          address_line_1: "123 Street",
          city: "Boston",
          state: CS.states(:US)[:MA],
          country: CS.countries[:US],
          zip_code: "02134",
          membership_status: "ACTIVE",
          privilege_limitations: false,
          started_at: 6.years.ago
        }
      )

      arguments = [affiliation_attrs]

      mutation = build_mutation(arguments)

      result = gql_query(query: mutation, user: nil)
      error_code = result.fetch("errors").fetch(0).fetch("extensions").fetch("code")

      expect(error_code).to eq "AUTHENTICATION_ERROR"
    end
  end

  def build_inputs(attrs_array)
    attrs_array.map do |affiliation_attrs|
      <<-GQL.strip_heredoc
        {
          facilityName: "#{affiliation_attrs.facility_name}",
          facilityType: "#{affiliation_attrs.facility_type}",
          departmentOrDivisionName: "#{affiliation_attrs.department_or_division_name}",
          addressLine1: "#{affiliation_attrs.address_line_1}",
          city: "#{affiliation_attrs.city}",
          state: "#{affiliation_attrs.state}",
          country: "#{affiliation_attrs.country}",
          zipCode: "#{affiliation_attrs.zip_code}",
          privilegeLimitations: #{affiliation_attrs.privilege_limitations},
          membershipStatus: #{affiliation_attrs.membership_status},
          startedAt: "#{affiliation_attrs.started_at.iso8601}",
          #{optional_datetime('endedAt', affiliation_attrs.ended_at)}
        }
      GQL
    end.join(",")
  end

  def build_mutation(attrs_array)
    <<-GQL.strip_heredoc
    mutation {
      updateHealthcareFacilityAffiliations(input: { healthcareFacilityAffiliationsAttributes: [#{build_inputs(attrs_array)}] })
      {
        healthcareFacilityAffiliations {
          facilityName
          membershipStatus
          privilegeLimitations
          startedAt
        }
      }
    }
    GQL
  end
end
