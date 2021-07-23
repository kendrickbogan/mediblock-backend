# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateCMECreditHoursMutation do
  context "with a valid request" do
    context "with required argments" do
      it "updates and returns the list of CME hour records" do
        person = create(:person)

        hours_1 = OpenStruct.new(
          {
            activity_date: 2.years.ago,
            activity_name: "some course",
            hours_earned: 1,
            method_of_education: "online"
          }
        )
        hours_2 = OpenStruct.new(
          {
            activity_date: 3.years.ago,
            activity_name: "other activity",
            hours_earned: 3,
            method_of_education: "method"
          }
        )

        arguments = [hours_1, hours_2]

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateCmeCreditHours")
        credit_hours = person.cme_credit_hours

        expect(credit_hours.length).to eq 2
        expect(data.dig("cmeCreditHours", 0, "activityName")).to eq hours_1.activity_name
        expect(data.dig("cmeCreditHours", 1, "activityName")).to eq hours_2.activity_name
      end
    end
  end

  context "when a user is not signed in" do
    it "returns an authentication error" do
      hours = OpenStruct.new(
        {
          activity_date: 2.years.ago,
          activity_name: "some course",
          hours_earned: 1,
          method_of_education: "online"
        }
      )

      arguments = [hours]

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
          activityName: "#{attrs.activity_name}",
          activityDate: "#{attrs.activity_date.iso8601}",
          hoursEarned: #{attrs.hours_earned},
          methodOfEducation: "#{attrs.method_of_education}",
          #{optional_string('sponsorName', attrs.sponsor_name)}
        }
      GQL
    end.join(",")
  end

  def build_mutation(attrs_array)
    <<-GQL.strip_heredoc
    mutation {
      updateCmeCreditHours(input: { cmeCreditHoursAttributes: [#{build_inputs(attrs_array)}] })
      {
        cmeCreditHours {
          activityName
        }
      }
    }
    GQL
  end
end
