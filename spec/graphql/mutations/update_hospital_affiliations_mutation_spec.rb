# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateHospitalAffiliationsMutation do
  context "with a valid request" do
    context "with required argments" do
      it "updates and returns the list of affiliations" do
        person = create(:person)

        affiliation_attrs = OpenStruct.new(
          {
            hospital_name: "BWH",
            department_name: "Medical",
            address_line_1: "123 Street",
            city: "Boston",
            state: CS.states(:US)[:MA],
            country: CS.countries[:US],
            zip_code: "02134",
            membership_status: "ACTIVE",
            started_at: 5.years.ago
          }
        )

        arguments = [affiliation_attrs]

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateHospitalAffiliations")
        hospital_affiliations = person.hospital_affiliations

        expect(hospital_affiliations.length).to eq 1
        expect(data.dig("hospitalAffiliations", 0, "hospitalName")).to eq affiliation_attrs.hospital_name
      end

      it "can create multiple records" do
        person = create(:person)

        affiliation_1 = OpenStruct.new(
          {
            hospital_name: "BWH",
            membership_status: "ACTIVE",
            started_at: 5.year.ago
          }
        )
        affiliation_2 = OpenStruct.new(
          {
            hospital_name: "MGH",
            membership_status: "ACTIVE",
            started_at: 5.year.ago
          }
        )

        arguments = [affiliation_1, affiliation_2]

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateHospitalAffiliations")

        hospital_affiliations = person.hospital_affiliations
        hospital_names = data["hospitalAffiliations"].map { |affiliation| affiliation["name"] }

        expect(hospital_affiliations.length).to eq 2
        expect(hospital_names).to match_array [affiliation_1.name, affiliation_2.name]
      end
    end
  end

  context "when a user is not signed in" do
    it "returns an unauthenticated error" do
      affiliation_attrs = OpenStruct.new(
        {
          hospital_name: "BWH",
          department_name: "Medical",
          address_line_1: "123 Street",
          city: "Boston",
          state: CS.states(:US)[:MA],
          country: CS.countries[:US],
          zip_code: "02134",
          membership_status: "ACTIVE",
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
          hospitalName: "#{affiliation_attrs.hospital_name}",
          departmentName: "#{affiliation_attrs.department_name}",
          addressLine1: "#{affiliation_attrs.address_line_1}",
          city: "#{affiliation_attrs.city}",
          state: "#{affiliation_attrs.state}",
          country: "#{affiliation_attrs.country}",
          zipCode: "#{affiliation_attrs.zip_code}",
          membershipStatus: #{affiliation_attrs.membership_status},
          startedAt: "#{affiliation_attrs.started_at.iso8601}"
        }
      GQL
    end.join(",")
  end

  def build_mutation(attrs_array)
    <<-GQL.strip_heredoc
    mutation {
      updateHospitalAffiliations(input: { hospitalAffiliationsAttributes: [#{build_inputs(attrs_array)}] })
      {
        hospitalAffiliations {
          hospitalName
        }
      }
    }
    GQL
  end
end
