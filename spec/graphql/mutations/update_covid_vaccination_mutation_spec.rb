# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateCOVIDVaccinationMutation do
  context "with a valid request" do
    context "with required argments" do
      it "updates and returns the vaccination record" do
        person =  create(:person)

        arguments = OpenStruct.new(
          {
            vaccination_date_1: 5.months.ago,
            vaccination_date_2: 4.months.ago,
            facility_name: "MGH"
          }
        )

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateCovidVaccination")
        vaccination = person.covid_vaccination

        expect(vaccination).to be
        expect(data.dig("covidVaccination", "vaccinationDate1")).to eq arguments.vaccination_date_1.iso8601
      end
    end
  end

  context "when a user is not signed in" do
    it "returns an authentication error" do
      arguments = OpenStruct.new(
        {
          vaccination_date_1: 5.months.ago,
          vaccination_date_2: 4.months.ago,
          facility_name: "MGH"
        }
      )

      mutation = build_mutation(arguments)

      result = gql_query(query: mutation, user: nil)
      error_code = result.fetch("errors").fetch(0).fetch("extensions").fetch("code")

      expect(error_code).to eq "AUTHENTICATION_ERROR"
    end
  end

  def build_mutation(attrs)
    <<-GQL.strip_heredoc
    mutation {
      updateCovidVaccination(input: {
        vaccinationDate1: "#{attrs.vaccination_date_1.iso8601}",
        vaccinationDate2: "#{attrs.vaccination_date_2.iso8601}",
        facilityName: "#{attrs.facility_name}"
      })
      {
        covidVaccination {
          vaccinationDate1
        }
      }
    }
    GQL
  end
end
