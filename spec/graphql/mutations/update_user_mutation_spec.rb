# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateUserMutation do
  context "with a valid request" do
    context "with required args" do
      it "updates and returns the user" do
        user = create(:user, onboarding_status: "account_created")

        arguments = OpenStruct.new(
          {
            onboarding_status: "IDENTITY_VERIFIED"
          }
        )

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: user)
        user_data = result.fetch("data").fetch("updateUser").fetch("user")
        user.reload

        expect(user.onboarding_status).to eq "identity_verified"
        expect(user_data["onboardingStatus"]).to eq arguments.onboarding_status
      end
    end
  end

  context "when a user is not signed in" do
    it "returns an authentication error" do
      arguments = OpenStruct.new(
        {
          onboarding_status: "IDENTITY_VERIFIED"
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
      updateUser(input: {
        onboardingStatus: #{attrs.onboarding_status}
      })
      {
        user {
          onboardingStatus
        }
      }
    }
    GQL
  end
end
