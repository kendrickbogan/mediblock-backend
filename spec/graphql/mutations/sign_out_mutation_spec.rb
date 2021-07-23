require "rails_helper"

RSpec.describe Mutations::SignOutMutation do
  context "when a user is signed in" do
    it "resets the remember_token and returns a success response" do
      user = create(:user)
      old_token = user.remember_token

      result = gql_query(query: mutation, user: user)
      data = result.fetch("data").fetch("signOut")

      expect(user.reload.remember_token).to_not eq old_token
      expect(data["success"]).to be true
    end
  end

  context "when a user is not signed in" do
    it "returns a failure response" do
      create(:user)

      result = gql_query(query: mutation)
      data = result.fetch("data").fetch("signOut")

      expect(data["success"]).to be false
    end
  end

  def mutation
    <<-GQL.strip_heredoc
    mutation {
      signOut
      {
        success
      }
    }
    GQL
  end
end
