# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateInsurancePoliciesMutation do
  context "with a valid request" do
    context "with required argments" do
      it "updates and returns the list of created policies" do
        person = create(:person)

        policy_1 = OpenStruct.new(
          {
            aggregate_amount: 1_100_000,
            covered_by_ftca: true,
            entity_name: "Insurance company",
            per_claim_amount: 250_000,
            self_insured: false,
            started_at: 1.years.ago,
            tail_coverage: true
          }
        )
        policy_2 = OpenStruct.new(
          {
            aggregate_amount: 1_100_000,
            covered_by_ftca: true,
            entity_name: "Other Company",
            per_claim_amount: 250_000,
            self_insured: false,
            started_at: 5.years.ago,
            tail_coverage: true,
            ended_at: 1.year.ago
          }
        )

        arguments = [policy_1, policy_2]

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateInsurancePolicies")
        insurance_policies = person.reload.insurance_policies

        expect(insurance_policies.length).to eq 2
        expect(data.dig("insurancePolicies", 0, "entityName")).to eq policy_1.entity_name
        expect(data.dig("insurancePolicies", 1, "entityName")).to eq policy_2.entity_name
      end
    end
  end

  context "when a user is not signed in" do
    it "returns an authentication error" do
      policy_1 = OpenStruct.new(
        {
          aggregate_amount: 1_100_000,
          covered_by_ftca: true,
          entity_name: "Insurance company",
          per_claim_amount: 250_000,
          self_insured: false,
          started_at: 1.years.ago,
          tail_coverage: true
        }
      )

      arguments = [policy_1]

      mutation = build_mutation(arguments)

      result = gql_query(query: mutation, user: nil)
      error_code = result.fetch("errors").fetch(0).fetch("extensions").fetch("code")

      expect(error_code).to eq "AUTHENTICATION_ERROR"
    end
  end

  def build_inputs(attrs_array)
    attrs_array.map do |policy_attrs|
      <<-GQL.strip_heredoc
        {
          aggregateAmount: #{policy_attrs.aggregate_amount},
          coveredByFtca: #{policy_attrs.covered_by_ftca},
          entityName: "#{policy_attrs.entity_name}",
          perClaimAmount: #{policy_attrs.per_claim_amount},
          selfInsured: #{policy_attrs.self_insured},
          startedAt: "#{policy_attrs.started_at.iso8601}",
          tailCoverage: #{policy_attrs.tail_coverage},
          #{optional_datetime('endedAt', policy_attrs.ended_at)}
        }
      GQL
    end.join(",")
  end

  def build_mutation(attrs_array)
    <<-GQL.strip_heredoc
    mutation {
      updateInsurancePolicies(input: { insurancePoliciesAttributes: [#{build_inputs(attrs_array)}] })
      {
        insurancePolicies {
          entityName
        }
      }
    }
    GQL
  end
end
