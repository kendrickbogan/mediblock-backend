# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateNationalHealthServiceCorpsScholarshipMutation do
  context "with a valid request" do
    context "with required args" do
      it "updates and returns the scholarship record" do
        person =  create(:person)

        arguments = OpenStruct.new(
          {
            started_at: 10.years.ago,
            ended_at: 8.years.ago
          }
        )

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateNationalHealthServiceCorpsScholarship")
        scholarship = person.national_health_service_corps_scholarship

        expect(scholarship).to be
        expect(data.dig("scholarship", "startedAt")).to eq arguments.started_at.iso8601
        expect(data.dig("scholarship", "endedAt")).to eq arguments.ended_at.iso8601
      end
    end
  end

  context "when a user is not signed in" do
    it "returns an authentication error" do
      arguments = OpenStruct.new(
        {
          started_at: 10.years.ago,
          ended_at: 8.years.ago
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
      updateNationalHealthServiceCorpsScholarship(input: {
        startedAt: "#{attrs.started_at.iso8601}",
        endedAt: "#{attrs.ended_at.iso8601}",
      })
      {
        scholarship {
          startedAt
          endedAt
        }
      }
    }
    GQL
  end
end
