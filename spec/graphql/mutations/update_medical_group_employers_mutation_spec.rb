# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateMedicalGroupEmployersMutation do
  context "with a valid request" do
    context "with required arguments" do
      it "updates and returns the list of medical groups/employers" do
        person = create(:person)

        medical_group_attrs =
          OpenStruct.new({ name: "Group Name", started_at: 5.years.ago })

        arguments = [medical_group_attrs]

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateMedicalGroupEmployers")
        medical_group_employers = person.medical_group_employers

        expect(medical_group_employers.length).to eq 1
        expect(
          data.dig("medicalGroupEmployers", 0, "name")
        ).to eq medical_group_attrs.name
      end

      it "can create multiple records" do
        person = create(:person)

        medical_group_1 =
          OpenStruct.new({ name: "Group Name", started_at: 5.years.ago })
        medical_group_2 =
          OpenStruct.new(
            { name: "Another Group Name", started_at: 6.years.ago }
          )

        arguments = [medical_group_1, medical_group_2]

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateMedicalGroupEmployers")

        medical_group_employers = person.medical_group_employers
        names =
          data["medicalGroupEmployers"].map do |medical_group|
            medical_group["name"]
          end

        expect(medical_group_employers.length).to eq 2
        expect(names).to match_array [
          medical_group_1.name,
          medical_group_2.name
        ]
      end
    end

    context "with all arguments" do
      it "updates and returns the list of medical groups/employers" do
        person = create(:person)

        medical_group_attrs =
          OpenStruct.new(
            {
              name: "Group Name",
              addressLine1: "123 Street Road",
              addressLine2: "Unit 2",
              city: "Boston",
              state: CS.states(:US)[:MA],
              country: CS.countries[:US],
              zip: "03245",
              phoneNumber: "7778889999",
              started_at: 5.years.ago,
              ended_at: 3.years.ago
            }
          )

        arguments = [medical_group_attrs]

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data =
          result.fetch("data").fetch("updateMedicalGroupEmployers").fetch(
            "medicalGroupEmployers"
          ).fetch(0)
        medical_group_employers = person.medical_group_employers

        expect(medical_group_employers.length).to eq 1
        expect(data["name"]).to eq medical_group_attrs.name
        expect(data["addressLine1"]).to eq medical_group_attrs
          .address_line_1
        expect(data["addressLine2"]).to eq medical_group_attrs
          .address_line_2
        expect(data["city"]).to eq medical_group_attrs.city
        expect(data["state"]).to eq medical_group_attrs.state
        expect(data["country"]).to eq medical_group_attrs.country
        expect(data["zip"]).to eq medical_group_attrs.zip
        expect(data["phoneNumber"]).to eq medical_group_attrs.phone_number
        expect(data["startedAt"]).to eq medical_group_attrs.started_at.iso8601
        expect(data["endedAt"]).to eq medical_group_attrs.ended_at.iso8601
      end
    end
  end

  context "when a person record is not found" do
    it "returns an authentication error" do
      medical_group_attrs =
        OpenStruct.new(
          {
            name: "Group Name",
            addressLine1: "123 Street Road",
            addressLine2: "Unit 2",
            city: "Boston",
            state: CS.states(:US)[:MA],
            country: CS.countries[:US],
            zip: "03245",
            phoneNumber: "7778889999",
            started_at: 5.years.ago,
            ended_at: 3.years.ago
          }
        )

      arguments = [medical_group_attrs]

      mutation = build_mutation(arguments)

      result = gql_query(query: mutation, user: nil)
      error_code = result.fetch("errors").fetch(0).fetch("extensions").fetch("code")

      expect(error_code).to eq "AUTHENTICATION_ERROR"
    end
  end

  def build_inputs(attrs_array)
    attrs_array.map do |medical_group_attrs|
      <<-GQL.strip_heredoc
        {
          name: "#{medical_group_attrs.name}",
          #{optional_string('addressLine1', medical_group_attrs.address_line_1)}
          #{optional_string('addressLine2', medical_group_attrs.address_line_2)}
          #{optional_string('city', medical_group_attrs.city)}
          #{optional_string('state', medical_group_attrs.state)}
          #{optional_string('country', medical_group_attrs.country)}
          #{optional_string('zip', medical_group_attrs.zip)}
          #{optional_string('phoneNumber', medical_group_attrs.phone_number)}
          startedAt: "#{medical_group_attrs.started_at.iso8601}",
          #{optional_datetime('endedAt', medical_group_attrs.ended_at)}
        }
      GQL
    end.join(",")
  end

  def build_mutation(attrs_array)
    <<-GQL.strip_heredoc
        mutation {
      updateMedicalGroupEmployers(input: { medicalGroupEmployersAttributes: [#{
      build_inputs(attrs_array)
    }] })
      {
        medicalGroupEmployers {
          name
          addressLine1
          addressLine2
          city
          state
          country
          zip
          phoneNumber
          startedAt
          endedAt
        }
      }
    }
    GQL
  end
end
