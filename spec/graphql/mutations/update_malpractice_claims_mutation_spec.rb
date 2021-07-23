# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateMalpracticeClaimsMutation do
  context "with a valid request" do
    context "with required argments" do
      it "updates and returns the list of malpractice claims" do
        person = create(:person)

        claim_1 = OpenStruct.new(
          {
            alleged_incident_date: 1.year.ago,
            amount_paid: 100_000,
            claim_filed_at: 1.year.ago,
            defendant_type: "PRIMARY",
            included_in_npdb: true,
            method_of_resolution: "OTHER",
            number_of_co_defendants: 0,
            settlement_amount: 100_000
          }
        )
        claim_2 = OpenStruct.new(
          {
            alleged_incident_date: 2.year.ago,
            amount_paid: 250_000,
            claim_filed_at: 2.year.ago,
            defendant_type: "PRIMARY",
            included_in_npdb: true,
            method_of_resolution: "OTHER",
            number_of_co_defendants: 1,
            settlement_amount: 250_000
          }
        )

        arguments = [claim_1, claim_2]

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateMalpracticeClaims")
        claims = person.malpractice_claims

        expect(claims.length).to eq 2
        expect(data.dig("malpracticeClaims", 0, "amountPaid")).to eq claim_1.amount_paid
        expect(data.dig("malpracticeClaims", 1, "amountPaid")).to eq claim_2.amount_paid
      end
    end
  end

  context "when a user is not signed in " do
    it "returns an authentication error" do
      claim_1 = OpenStruct.new(
        {
          alleged_incident_date: 1.year.ago,
          amount_paid: 100_000,
          claim_filed_at: 1.year.ago,
          defendant_type: "PRIMARY",
          included_in_npdb: true,
          method_of_resolution: "OTHER",
          number_of_co_defendants: 0,
          settlement_amount: 100_000
        }
      )
      claim_2 = OpenStruct.new(
        {
          alleged_incident_date: 2.year.ago,
          amount_paid: 250_000,
          claim_filed_at: 2.year.ago,
          defendant_type: "PRIMARY",
          included_in_npdb: true,
          method_of_resolution: "OTHER",
          number_of_co_defendants: 1,
          settlement_amount: 250_000
        }
      )

      arguments = [claim_1, claim_2]

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
          allegedIncidentDate: "#{attrs.alleged_incident_date.iso8601}",
          amountPaid: #{attrs.amount_paid},
          claimFiledAt: "#{attrs.claim_filed_at.iso8601}",
          defendantType: #{attrs.defendant_type},
          includedInNpdb: #{attrs.included_in_npdb},
          methodOfResolution: #{attrs.method_of_resolution},
          numberOfCoDefendants: #{attrs.number_of_co_defendants},
          settlementAmount: #{attrs.settlement_amount},
        }
      GQL
    end.join(",")
  end

  def build_mutation(attrs_array)
    <<-GQL.strip_heredoc
    mutation {
      updateMalpracticeClaims(input: { malpracticeClaimsAttributes: [#{build_inputs(attrs_array)}] })
      {
        malpracticeClaims {
          amountPaid
        }
      }
    }
    GQL
  end
end
