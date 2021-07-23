require "rails_helper"

RSpec.describe "Personal details query request" do
  context "with a valid auth token" do
    it "makes a successful request" do
      person = create(:person)

      post "/graphql",
           params: { query: query_string },
           headers: { Authorization: "Bearer #{person.user.remember_token}" }

      response_body = JSON.parse(response.body)

      expect(response_body).to eq(
        { "data" => { "personalDetails" => { "firstName" => person.first_name } } }
      )
    end
  end

  context "without a valid auth token" do
    it "returns an authentication error" do
      create(:person)

      post "/graphql",
           params: { query: query_string },
           headers: { Authorization: "" }

      response_body = JSON.parse(response.body)

      expect(response_body).to eq(
        {
          "data" => { "personalDetails" => nil },
          "errors" => [
            {
              "message" => "You must be signed in to view this information",
              "locations" => [{ "line" => 2, "column" => 3 }],
              "path" => ["personalDetails"], "extensions" => { "code" => "AUTHENTICATION_ERROR" }
            }
          ]
        }
      )
    end
  end

  def query_string
    <<-GQL.strip_heredoc
      {
        personalDetails {
          firstName
        }
      }
    GQL
  end
end
