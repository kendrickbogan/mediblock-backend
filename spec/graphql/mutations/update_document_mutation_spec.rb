require "rails_helper"

RSpec.describe Mutations::UpdateDocumentMutation do
  context "with an authenticated user" do
    it "updates and returns the document" do
      person = create(:person)
      document = create(
        :document,
        attachment: Rack::Test::UploadedFile.new("spec/test_upload.jpg", "image/jpg"),
        category: "education_and_training",
        kind: "undergraduate_diploma",
        name: "My document",
        person: person,
        profile_section: "undergraduate_degree"
      )

      args = OpenStruct.new(
        attachment_data: build_base64_image,
        category: "GENERAL_INFORMATION",
        expires_at: 10.years.from_now,
        id: document.id,
        kind: "UNDERGRADUATE_DIPLOMA",
        name: "new name",
        profile_section: "OTHER_DEGREE"
      )

      mutation = build_mutation(args)
      result = gql_query(query: mutation, user: person.user)
      doc = result.fetch("data").fetch("updateDocument").fetch("document")

      expect(doc["name"]).to eq args.name
      expect(doc["category"]).to eq args.category
      expect(doc["kind"]).to eq args.kind
      expect(doc["expiresAt"]).to eq args.expires_at.iso8601
      expect(doc["profileSection"]).to eq args.profile_section
      expect(doc["attachment"]["url"]).to be_present
      expect(doc["attachment"]["contentType"]).to eq new_content_type
    end

    context "when a document is not found by the given ID" do
      it "returns nil" do
        person = create(:person)
        create(:document, person: person)

        args = OpenStruct.new(
          attachment_data: build_base64_image,
          category: "GENERAL_INFORMATION",
          expires_at: 10.years.from_now,
          id: "some id",
          kind: "UNDERGRADUATE_DIPLOMA",
          name: "new name",
          profile_section: "UNDERGRADUATE_DEGREE"
        )

        mutation = build_mutation(args)
        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateDocument")

        expect(data["document"]).to be_nil
      end
    end
  end

  context "without an authenticated user" do
    it "returns an authentication error" do
      person = create(:person)
      create(:document, person: person)

      args = OpenStruct.new(
        attachment_data: build_base64_image,
        category: "GENERAL_INFORMATION",
        expires_at: 10.years.from_now,
        id: "some id",
        kind: "UNDERGRADUATE_DIPLOMA",
        name: "new name",
        profile_section: "UNDERGRADUATE_DEGREE"
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
        updateDocument(input: {
          id: "#{args.id}",
          name: "#{args.name}",
          category: #{args.category},
          kind: #{args.kind},
          profileSection: #{args.profile_section},
          attachment: { data: "#{args.attachment_data}" },
          #{optional_datetime('expiresAt', args.expires_at)}
        })
        {
          document {
            id
            name
            category
            kind
            expiresAt
            profileSection
            attachment {
              url
              contentType
            }
          }
        }
      }
    GQL
  end

  def new_content_type
    "image/png"
  end

  def build_base64_image
    test_image = File.open("spec/test_upload_2.png").read
    "data:#{new_content_type};base64,#{Base64.strict_encode64(test_image)}"
  end
end
