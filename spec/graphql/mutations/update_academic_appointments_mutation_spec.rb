# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateAcademicAppointmentsMutation do
  context "with a valid request" do
    context "with required argments" do
      it "updates and returns the list of academic appointments" do
        person = create(:person)

        appointment_1 = OpenStruct.new(
          {
            position: "Professor",
            institution_name: "Boston University",
            institution_url: "something.com",
            address_line_1: "123 street",
            city: "Boston",
            state: CS.states(:US)[:MA],
            country: CS.countries[:US],
            zip: "02151",
            started_at: 1.year.ago
          }
        )
        appointment_2 = OpenStruct.new(
          {
            position: "Assistant Professor",
            institution_name: "University of Something",
            institution_url: "something.com",
            address_line_1: "123 street",
            city: "Winchester",
            state: CS.states(:US)[:MA],
            country: CS.countries[:US],
            zip: "02214",
            started_at: 5.years.ago,
            ended_at: 1.year.ago
          }
        )

        arguments = [appointment_1, appointment_2]

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateAcademicAppointments")
        academic_appointments = person.academic_appointments

        expect(academic_appointments.length).to eq 2
        expect(data.dig("academicAppointments", 0, "position")).to eq appointment_1.position
        expect(data.dig("academicAppointments", 1, "position")).to eq appointment_2.position
      end
    end
  end

  context "when a user is not signed in" do
    it "returns an authentication error" do
      appointment = OpenStruct.new(
        {
          position: "Professor",
          institution_name: "Boston University",
          institution_url: "something.com",
          address_line_1: "123 street",
          city: "Boston",
          state: CS.states(:US)[:MA],
          country: CS.countries[:US],
          zip: "02151",
          started_at: 1.year.ago
        }
      )

      arguments = [appointment]

      mutation = build_mutation(arguments)

      result = gql_query(query: mutation, user: nil)
      error_code = result.fetch("errors").fetch(0).fetch("extensions").fetch("code")

      expect(error_code).to eq "AUTHENTICATION_ERROR"
    end
  end

  def build_inputs(attrs_array)
    attrs_array.map do |attrs|
      <<-GQL.strip_heredoc
        {
          position: "#{attrs.position}",
          institutionName: "#{attrs.institution_name}",
          institutionUrl: "#{attrs.institution_url}",
          addressLine1: "#{attrs.address_line_1}",
          city: "#{attrs.city}",
          state: "#{attrs.state}",
          zip: "#{attrs.zip}",
          country: "#{attrs.country}",
          startedAt: "#{attrs.started_at.iso8601}",
          #{optional_datetime('endedAt', attrs.ended_at)}
        }
      GQL
    end.join(",")
  end

  def build_mutation(attrs_array)
    <<-GQL.strip_heredoc
    mutation {
      updateAcademicAppointments(input: { academicAppointmentsAttributes: [#{build_inputs(attrs_array)}] })
      {
        academicAppointments {
          position
        }
      }
    }
    GQL
  end
end
