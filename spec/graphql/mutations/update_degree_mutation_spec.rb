# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateDegreeMutation do
  context "with a valid request" do
    context "with required argments" do
      it "updates and returns the degree record" do
        person =  create(:person)

        arguments = OpenStruct.new(
          {
            institution_name: "Boston College",
            kind: "UNDERGRADUATE",
            degree: "Bachelor",
            major: "Biology",
            minor: "Ancient Greek",
            date_of_graduation: 5.years.ago.iso8601,
            started_at: 8.year.ago.iso8601,
            ended_at: 5.years.ago.iso8601,
            registrar_phone_number: "9999999999",
            registrar_url: "something.com",
            institution_address_line_1: "123 Johnson Street",
            institution_address_city: "Boston",
            institution_address_state: CS.states(:US)[:MA],
            institution_address_zip: "02213",
            institution_address_country: CS.countries[:US]
          }
        )

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateDegree")

        expect(person.reload.undergraduate_degree).to be
        expect(data.dig("degree", "kind")).to eq arguments.kind
      end
    end

    it "can create a degree with kind 'other'" do
      person =  create(:person)

      arguments = OpenStruct.new(
        {
          institution_name: "Boston College",
          kind: "OTHER",
          degree: "Bachelor",
          date_of_graduation: 5.years.ago.iso8601,
          started_at: 8.year.ago.iso8601,
          ended_at: 5.years.ago.iso8601,
          registrar_phone_number: "9999999999",
          registrar_url: "something.com",
          institution_address_line_1: "123 Johnson Street",
          institution_address_city: "Boston",
          institution_address_state: CS.states(:US)[:MA],
          institution_address_zip: "02213",
          institution_address_country: CS.countries[:US]
        }
      )

      mutation = build_mutation(arguments)

      result = gql_query(query: mutation, user: person.user)
      data = result.fetch("data").fetch("updateDegree")

      expect(person.reload.other_degree).to be
      expect(data.dig("degree", "kind")).to eq arguments.kind
    end
  end

  context "when a user is not signed in" do
    it "returns an authentication error" do
      arguments = OpenStruct.new(
        {
          institution_name: "Boston College",
          kind: "UNDERGRADUATE",
          degree: "Bachelor",
          major: "Biology",
          minor: "Ancient Greek",
          date_of_graduation: 5.years.ago.iso8601,
          started_at: 8.year.ago.iso8601,
          ended_at: 5.years.ago.iso8601,
          registrar_phone_number: "9999999999",
          registrar_url: "something.com",
          institution_address_line_1: "123 Johnson Street",
          institution_address_city: "Boston",
          institution_address_state: CS.states(:US)[:MA],
          institution_address_zip: "02213",
          institution_address_country: CS.countries[:US]
        }
      )

      mutation = build_mutation(arguments)

      result = gql_query(query: mutation, user: nil)
      error_code = result.fetch("errors").fetch(0).fetch("extensions").fetch("code")

      expect(error_code).to eq "AUTHENTICATION_ERROR"
    end
  end

  def build_mutation(degree_attrs)
    <<-GQL.strip_heredoc
    mutation {
      updateDegree(input: {
        institutionName: "#{degree_attrs.institution_name}",
        kind: #{degree_attrs.kind},
        degree: "#{degree_attrs.degree}",
        major: "#{degree_attrs.major}",
        minor: "#{degree_attrs.minor}",
        dateOfGraduation: "#{degree_attrs.date_of_graduation}",
        startedAt: "#{degree_attrs.started_at}",
        endedAt: "#{degree_attrs.ended_at}",
        registrarPhoneNumber: "#{degree_attrs.registrar_phone_number}"
        registrarUrl: "#{degree_attrs.registrar_url}"
        institutionAddressLine1: "#{degree_attrs.institution_address_line_1}"
        institutionAddressCity: "#{degree_attrs.institution_address_city}"
        institutionAddressState: "#{degree_attrs.institution_address_state}"
        institutionAddressZip: "#{degree_attrs.institution_address_zip}"
        institutionAddressCountry: "#{degree_attrs.institution_address_country}"
      })
      {
        degree {
          kind
        }
      }
    }
    GQL
  end
end
