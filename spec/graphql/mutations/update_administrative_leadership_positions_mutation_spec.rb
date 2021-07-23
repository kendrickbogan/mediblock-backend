# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateAdministrativeLeadershipPositionsMutation do
  context "with a valid request" do
    context "with required argments" do
      it "updates and returns the list of affiliations" do
        person = create(:person)

        position_1 = OpenStruct.new(
          {
            title: "The Big Guy",
            started_at: 5.days.ago,
            ended_at: 1.days.ago
          }
        )
        position_2 = OpenStruct.new(
          {
            title: "The Little Dude",
            started_at: 1.day.ago
          }
        )

        arguments = [position_1, position_2]

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateAdministrativeLeadershipPositions")
        positions = person.reload.administrative_leadership_positions

        expect(positions.length).to eq 2
        expect(data.dig("administrativeLeadershipPositions", 0, "title")).to eq position_1.title
        expect(data.dig("administrativeLeadershipPositions", 1, "title")).to eq position_2.title
      end
    end
  end

  context "when a user is not signed in" do
    it "returns an authentication error" do
      position_1 = OpenStruct.new(
        {
          title: "The Big Guy",
          started_at: 5.days.ago,
          ended_at: 1.days.ago
        }
      )

      arguments = [position_1]

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
          title: "#{attrs.title}",
          startedAt: "#{attrs.started_at.iso8601}"
          #{optional_datetime('endedAt', attrs.ended_at)}
        }
      GQL
    end.join(",")
  end

  def build_mutation(attrs_array)
    <<-GQL.strip_heredoc
    mutation {
      updateAdministrativeLeadershipPositions(
        input: {
          administrativeLeadershipPositionsAttributes: [#{build_inputs(attrs_array)}]
        }
      )
      {
        administrativeLeadershipPositions {
          title
        }
      }
    }
    GQL
  end
end
