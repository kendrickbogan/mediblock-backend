# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateCertificationMutation do
  context "with a valid request" do
    context "with required argments" do
      it "updates and returns the certifications" do
        person = create(:person)

        args = OpenStruct.new(
          {
            kind: "CPR",
            issued_at: 1.year.ago
          }
        )

        mutation = build_mutation(args)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateCertification")
        certifications = person.certifications

        expect(certifications.length).to eq 1
        expect(data.dig("certification", "name")).to eq args.kind
      end
    end
  end

  context "when a person record is not found" do
    it "returns nil" do
      args = OpenStruct.new(
        {
          kind: "CPR",
          issued_at: 1.year.ago
        }
      )

      mutation = build_mutation(args)

      result = gql_query(query: mutation, user: nil)
      error_code = result.fetch("errors").fetch(0).fetch("extensions").fetch("code")

      expect(error_code).to eq "AUTHENTICATION_ERROR"
    end
  end

  def build_mutation(attrs)
    <<-GQL.strip_heredoc
    mutation {
      updateCertification(input: {
        kind: #{attrs.kind},
        issuedAt: "#{attrs.issued_at.iso8601}",
        #{optional_datetime('expiresAt', attrs.expires_at)}
      })
      {
        certification {
          issuedAt
          name
          kind
        }
      }
    }
    GQL
  end
end
