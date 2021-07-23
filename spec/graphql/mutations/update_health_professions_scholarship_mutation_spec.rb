# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateLoanRepaymentDetailMutation do
  context "with required arguments" do
    it "updates and returns the health professions scholarship" do
      person = create(:person)

      arguments = OpenStruct.new(
        {
          military_branch_scholarship_sponsor: "Military Branch",
          started_at: 10.years.ago,
          ended_at: 6.years.ago
        }
      )

      mutation = build_mutation(arguments)

      result = gql_query(query: mutation, user: person.user)
      data = result.fetch("data").fetch("updateHealthProfessionsScholarship")
        .fetch("healthProfessionsScholarship")

      expect(data["militaryBranchScholarshipSponsor"]).to eq arguments.military_branch_scholarship_sponsor
      expect(data["startedAt"]).to eq arguments.started_at.iso8601
      expect(data["endedAt"]).to eq arguments.ended_at.iso8601
    end
  end

  context "when a user is not signed in" do
    it "returns an authentication error" do
      arguments = OpenStruct.new(
        {
          military_branch_scholarship_sponsor: "Military Branch",
          started_at: 10.years.ago,
          ended_at: 6.years.ago
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
      updateHealthProfessionsScholarship(input: {
        militaryBranchScholarshipSponsor: "#{attrs.military_branch_scholarship_sponsor}",
        startedAt: "#{attrs.started_at.iso8601}",
        endedAt: "#{attrs.ended_at.iso8601}",
      })
      {
        healthProfessionsScholarship {
          militaryBranchScholarshipSponsor
          startedAt
          endedAt
        }
      }
    }
    GQL
  end
end
