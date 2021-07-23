require "rails_helper"

RSpec.describe Mutations::CreateDocumentMutation do
  context "with an authenticated user" do
    it "creates and returns a new document" do
      person = create(:person)

      args = OpenStruct.new(
        name: "My document",
        category: "GENERAL_INFORMATION",
        kind: "UNDERGRADUATE_DIPLOMA",
        attachment_data: build_base64_image,
        expires_at: 5.years.from_now,
        profile_section: "UNDERGRADUATE_DEGREE"
      )

      mutation = build_mutation(args)
      result = gql_query(query: mutation, user: person.user)
      document = result.fetch("data").fetch("createDocument").fetch("document")

      expect(document["name"]).to eq args.name
      expect(document["category"]).to eq args.category
      expect(document["kind"]).to eq args.kind
      expect(document["expiresAt"]).to eq args.expires_at.iso8601
      expect(document["profileSection"]).to eq args.profile_section
      expect(document["attachment"]["url"]).to be_present
    end
  end

  context "without an authenticated user" do
    it "returns an authentication error" do
      create(:person)

      args = OpenStruct.new(
        name: "My document",
        category: "GENERAL_INFORMATION",
        kind: "UNDERGRADUATE_DIPLOMA",
        attachment_data: build_base64_image,
        expires_at: 5.years.from_now,
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
        createDocument(input: {
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

  def build_base64_image
    test_image = File.open("spec/test_upload.jpg").read
    "data:image/jpg;base64,#{Base64.strict_encode64(test_image)}"
  end
end
