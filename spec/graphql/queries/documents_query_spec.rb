require "rails_helper"

RSpec.describe "Documents query" do
  context "for a signed in user" do
    it "returns the list of their documents for the given category" do
      person = create(:person)
      document = create(:document, person: person)
      create(:document, category: "employment_history", person: person)

      query = build_query(document.category.upcase)
      result = gql_query(query: query, user: person.user)
      data = result.fetch("data").fetch("personalDetails").fetch("documents")

      expect(data.length).to eq 1

      doc = data.first
      expect(doc["id"]).to eq document.id.to_s
      expect(doc["name"]).to eq document.name
      expect(doc["expiresAt"]).to eq document.expires_at.iso8601
      expect(doc["category"]).to eq document.category.upcase
      expect(doc["attachment"]["url"]).to be_present
      expect(doc["attachment"]["previewUrl"]).to be_present
      expect(doc["attachment"]["contentType"]).to eq document.attachment.content_type
    end

    context "when the attachment is a PDF" do
      it "successfully generates a preview url for the attachment" do
        person = create(:person)
        document = create(:document, attachment: pdf_attachment_data, person: person)

        query = build_query(document.category.upcase)
        result = gql_query(query: query, user: person.user)
        data = result.fetch("data").fetch("personalDetails").fetch("documents")
        attachment = data.fetch(0).fetch("attachment")

        expect(attachment["previewUrl"]).to be_present
      end
    end
  end

  context "for an unauthenticated user" do
    it "returns nothing" do
      person = create(:person)
      document = create(:document, person: person)
      create(:document, category: "employment_history", person: person)

      query = build_query(document.category.upcase)
      result = gql_query(query: query, user: nil)
      data = result.fetch("data").fetch("personalDetails")

      expect(data).to be_nil
    end
  end

  def pdf_attachment_data
    Rack::Test::UploadedFile.new("spec/test_pdf.pdf", "application/pdf")
  end

  def build_query(category)
    <<-GQL.strip_heredoc
    query {
      personalDetails {
        documents(category: #{category}) {
          id
          name
          category
          expiresAt
          attachment {
            url
            previewUrl
            contentType
          }
        }
      }
    }
    GQL
  end
end
