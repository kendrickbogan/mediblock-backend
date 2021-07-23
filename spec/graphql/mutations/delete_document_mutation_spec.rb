require "rails_helper"

RSpec.describe Mutations::DeleteDocumentMutation do
  context "for a signed in user" do
    it "soft deletes the document for the given ID" do
      person = create(:person)
      document = create(:document, person: person)

      query = build_query(document.id)
      result = gql_query(query: query, user: person.user)
      data = result.fetch("data").fetch("deleteDocument")

      documents = person.reload.documents.not_deleted
      expect(documents).to be_empty
      expect(data["id"]).to eq document.id.to_s
    end

    context "when the document is not found for the given ID" do
      it "returns nil" do
        person = create(:person)

        query = build_query(2)
        result = gql_query(query: query, user: person.user)
        data = result.fetch("data").fetch("deleteDocument")

        expect(data["id"]).to be_nil
      end
    end
  end

  context "for an unauthenticated user" do
    it "returns nothing" do
      person = create(:person)
      document = create(:document, person: person)

      query = build_query(document.id)
      result = gql_query(query: query, user: nil)
      data = result.fetch("data").fetch("deleteDocument")

      expect(data).to be_nil
    end
  end

  def build_query(id)
    <<-GQL.strip_heredoc
    mutation {
      deleteDocument(input: {id: #{id}}) {
        id
      }
    }
    GQL
  end
end
