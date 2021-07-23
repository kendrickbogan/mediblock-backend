require "rails_helper"

RSpec.describe Mutations::SignUpMutation do
  context "with valid parameters" do
    it "returns a user" do
      new_user = build(:user)

      arguments = OpenStruct.new(
        {
          email: new_user.email,
          password: new_user.password,
          first_name: "First",
          last_name: "Last"
        }
      )

      mutation = build_mutation(arguments)
      result = gql_query(query: mutation)
      user_data = result.fetch("data").fetch("signUp").fetch("user")
      user = User.first

      expect(user.email).to eq new_user.email
      expect(user_data["authorizationToken"]).to eq user.remember_token
      expect(user_data["person"]["firstName"]).to eq arguments.first_name
    end
  end

  context "with invalid parameters" do
    it "returns nil" do
      arguments = OpenStruct.new(
        {
          email: "whatever",
          password: nil,
          first_name: "First",
          last_name: "Last"
        }
      )

      mutation = build_mutation(arguments)
      result = gql_query(query: mutation)
      data = result.fetch("data")

      expect(data["signUp"]).to be_nil
    end
  end

  def build_mutation(attrs)
    <<-GQL.strip_heredoc
    mutation {
      signUp(input: {
        email: "#{attrs.email}",
        password: "#{attrs.password}",
        firstName: "#{attrs.first_name}",
        lastName: "#{attrs.last_name}",
      })
      {
        user {
          authorizationToken
          person {
            firstName
          }
        }
      }
    }
    GQL
  end
end
