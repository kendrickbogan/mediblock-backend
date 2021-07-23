require "rails_helper"

RSpec.describe Mutations::SignInMutation do
  context "with valid credentials" do
    it "returns a user" do
      user = create(:user)

      arguments = OpenStruct.new(
        {
          email: user.email,
          password: user.password
        }
      )

      mutation = build_mutation(arguments)
      result = gql_query(query: mutation)
      user_data = result.fetch("data").fetch("signIn").fetch("user")

      expect(user_data["authorizationToken"]).to eq user.remember_token
    end
  end

  context "with invalid credentials" do
    it "returns nil" do
      user = create(:user)

      arguments = OpenStruct.new(
        {
          email: user.email,
          password: "bad password"
        }
      )

      mutation = build_mutation(arguments)
      result = gql_query(query: mutation)
      data = result.fetch("data")

      expect(data["signIn"]).to be_nil
    end
  end

  def build_mutation(attrs)
    <<-GQL.strip_heredoc
    mutation {
      signIn(input: {
        email: "#{attrs.email}",
        password: "#{attrs.password}",
      })
      {
        user {
          authorizationToken
        }
      }
    }
    GQL
  end
end
