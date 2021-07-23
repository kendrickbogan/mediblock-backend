# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdatePriorNamesMutation do
  context "with a valid request" do
    context "with required argments" do
      it "updates and returns the list of prior name records" do
        person = create(:person)

        name_1 = OpenStruct.new(
          {
            started_at: 2.years.ago,
            ended_at: 1.year.ago,
            name: "John Johnson"
          }
        )
        name_2 = OpenStruct.new(
          {
            started_at: 5.years.ago,
            ended_at: 2.year.ago,
            name: "Just Jim",
            comment: "They called me Jim"
          }
        )

        arguments = [name_1, name_2]

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updatePriorNames")
        prior_names = person.prior_names

        expect(prior_names.length).to eq 2
        expect(data.dig("priorNames", 0, "name")).to eq name_1.name
        expect(data.dig("priorNames", 1, "name")).to eq name_2.name
      end
    end
  end

  context "when a user is not signed in" do
    it "returns an authentication error" do
      name = OpenStruct.new(
        {
          started_at: 2.years.ago,
          ended_at: 1.year.ago,
          name: "John Johnson"
        }
      )

      arguments = [name]

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
          name: "#{attrs.name}",
          startedAt: "#{attrs.started_at.iso8601}",
          endedAt: "#{attrs.ended_at.iso8601}",
          #{optional_string('comment', attrs.comment)}
        }
      GQL
    end.join(",")
  end

  def build_mutation(attrs_array)
    <<-GQL.strip_heredoc
    mutation {
      updatePriorNames(input: { priorNamesAttributes: [#{build_inputs(attrs_array)}] })
      {
        priorNames {
          name
        }
      }
    }
    GQL
  end
end
