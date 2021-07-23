# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateDemographicDetailMutation do
  context "with required arguments" do
    it "updates and returns the demographic detail" do
      person = create(:person)

      arguments = OpenStruct.new(
        {
          race: %w[WHITE ASIAN],
          ethnicity: "HISPANIC_OR_LATINO"
        }
      )

      mutation = build_mutation(arguments)

      result = gql_query(query: mutation, user: person.user)
      data = result.fetch("data").fetch("updateDemographicDetail")
        .fetch("demographicDetail")

      expect(data["race"]).to eq arguments.race
      expect(data["ethnicity"]).to eq arguments.ethnicity
    end
  end

  context "when a user is not signed in" do
    it "returns an authentication error" do
      arguments = OpenStruct.new(
        {
          race: ["WHITE"],
          ethnicity: "HISPANIC_OR_LATINO"
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
      updateDemographicDetail(input: {
        race: [#{attrs.race.join(', ')}],
        ethnicity: #{attrs.ethnicity},
      })
      {
        demographicDetail {
          race
          ethnicity
        }
      }
    }
    GQL
  end
end
