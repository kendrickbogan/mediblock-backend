require "rails_helper"

RSpec.describe Mutations::ShareDocumentsMutation do
  context "with an authenticated user" do
    it "creates and returns a sharing event" do
      person = create(:person)
      documents = create_list(:document, 2, person: person)
      document_ids = documents.map { |doc| doc.id.to_s }

      args = OpenStruct.new(
        sent_from_email: "sentfrom@example.com",
        recipient_emails: ["recipient1@example.com", "recipient2@example.com"],
        categories_included: ["GENERAL_INFORMATION"],
        document_ids: document_ids
      )

      mutation = build_mutation(args)
      result = gql_query(query: mutation, user: person.user)
      event = result.fetch("data").fetch("shareDocuments").fetch("sharingEvent")
      event_doc_ids = event["documents"].map { |doc| doc["id"] }

      expect(event["sentFromEmail"]).to eq args.sent_from_email
      expect(event["recipientEmails"]).to eq args.recipient_emails
      expect(event["categoriesIncluded"]).to eq args.categories_included
      expect(event_doc_ids).to eq args.document_ids
    end
  end

  context "without an authenticated user" do
    it "returns an authentication error" do
      person = create(:person)
      documents = create_list(:document, 2, person: person)
      document_ids = documents.map { |doc| doc.id.to_s }

      args = OpenStruct.new(
        sent_from_email: "sentfrom@example.com",
        recipient_emails: ["recipient1@example.com", "recipient2@example.com"],
        categories_included: ["GENERAL_INFORMATION"],
        document_ids: document_ids
      )

      mutation = build_mutation(args)
      result = gql_query(query: mutation, user: nil)
      error_code = result.fetch("errors").fetch(0).fetch("extensions").fetch("code")

      expect(error_code).to eq "AUTHENTICATION_ERROR"
    end
  end

  def build_mutation(args)
    <<-GQL.strip_heredoc
      mutation {
        shareDocuments(input: {
          sentFromEmail: "#{args.sent_from_email}",
          recipientEmails: #{args.recipient_emails},
          categoriesIncluded: [#{args.categories_included.join(', ')}],
          documentIds: #{args.document_ids},
        })
        {
          sharingEvent {
            id
            sentFromEmail
            recipientEmails
            categoriesIncluded
            documents {
              id
            }
          }
        }
      }
    GQL
  end
end
