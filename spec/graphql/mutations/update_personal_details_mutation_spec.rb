# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdatePersonalDetailsMutation do
  context "with a valid request" do
    context "with required argments" do
      it "updates and returns the Person record" do
        person = create(:person)

        arguments = OpenStruct.new(
          {
            first_name: "Jeff",
            last_name: "Goldblum",
            legal_gender: "FEMALE"
          }
        )

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updatePersonalDetails")

        expect(data.dig("personalDetails", "firstName")).to eq arguments.first_name
        expect(data.dig("personalDetails", "lastName")).to eq arguments.last_name
        expect(data.dig("personalDetails", "legalGender")).to eq arguments.legal_gender
      end
    end

    context "with all args" do
      it "updates and returns the Person record" do
        person = create(:person)

        arguments = OpenStruct.new(
          {
            first_name: "Jeff",
            last_name: "Goldblum",
            legal_gender: "FEMALE",
            cell_phone_number: "9787777777",
            emergency_contact_number: "1234567891"
          }
        )

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updatePersonalDetails")

        expect(data.dig("personalDetails", "firstName")).to eq arguments.first_name
        expect(data.dig("personalDetails", "lastName")).to eq arguments.last_name
        expect(data.dig("personalDetails", "legalGender")).to eq arguments.legal_gender
        expect(data.dig("personalDetails", "cellPhoneNumber")).to eq arguments.cell_phone_number
        expect(data.dig("personalDetails", "emergencyContactNumber")).to eq arguments.emergency_contact_number
      end
    end
  end

  context "with an invalid request" do
    context "with invalid argument values such as blank first name" do
      it "returns nil" do
        person = create(:person)

        arguments = OpenStruct.new(
          {
            first_name: "",
            last_name: "Goldblum",
            legal_gender: "FEMALE"
          }
        )

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updatePersonalDetails")

        expect(data["personalDetails"]).to be_nil
      end
    end
  end

  context "when a person record is not found" do
    it "returns nil" do
      arguments = OpenStruct.new(
        {
          first_name: "Jeff",
          last_name: "Goldblum",
          legal_gender: "FEMALE"
        }
      )

      mutation = build_mutation(arguments)

      result = gql_query(query: mutation, user: nil)
      error_code = result.fetch("errors").fetch(0).fetch("extensions").fetch("code")

      expect(error_code).to eq "AUTHENTICATION_ERROR"
    end
  end

  def build_mutation(person_attrs)
    <<-GQL.strip_heredoc
    mutation {
      updatePersonalDetails(input: {
        firstName: "#{person_attrs.first_name}",
        lastName: "#{person_attrs.last_name}",
        #{optional_string('middleName', person_attrs.middle_name)}
        #{optional_string('maidenName', person_attrs.maiden_name)}
        #{optional_string('suffix', person_attrs.suffix)}
        legalGender: #{person_attrs.legal_gender},
        #{optional_string('cellPhoneNumber', person_attrs.cell_phone_number)}
        #{optional_string('emergencyContactNumber', person_attrs.emergency_contact_number)}
      })
      {
        personalDetails {
          firstName
          lastName
          middleName
          maidenName
          suffix
          legalGender
          cellPhoneNumber
          emergencyContactNumber
        }
      }
    }
    GQL
  end
end
