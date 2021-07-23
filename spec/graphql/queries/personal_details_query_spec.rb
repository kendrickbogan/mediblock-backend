require "rails_helper"

RSpec.describe "PersonalDetailsQuery" do
  context "with a signed in user" do
    it "returns the user's personal details" do
      person = create(:person)
      result = gql_query(query: query, user: person.user)
      data = result.fetch("data").fetch("personalDetails")

      expect(data["firstName"]).to eq person.first_name
    end
  end

  context "without a signed in user" do
    it "returns nil" do
      create(:person)
      result = gql_query(query: query, user: nil)
      error_code = result.fetch("errors").fetch(0).fetch("extensions").fetch("code")

      expect(error_code).to eq "AUTHENTICATION_ERROR"
    end
  end

  def query
    <<-GQL.strip_heredoc
    query {
      personalDetails {
        firstName
      }
    }
    GQL
  end
end
