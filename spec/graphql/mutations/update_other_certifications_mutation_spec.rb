# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateOtherCertificationsMutation do
  context "with a valid request" do
    context "with required argments" do
      it "updates and returns the list of other certifications" do
        person = create(:person)

        cert_1 = OpenStruct.new(
          {
            other_name: "Other certification",
            issued_at: 1.year.ago
          }
        )
        cert_2 = OpenStruct.new(
          {
            other_name: "This is a certification",
            issued_at: 2.year.ago,
            expires_at: 1.year.from_now
          }
        )

        arguments = [cert_1, cert_2]

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateOtherCertifications")
        certifications = person.certifications

        expect(certifications.length).to eq 2
        expect(data.dig("otherCertifications", 0, "name")).to eq cert_1.other_name
        expect(data.dig("otherCertifications", 1, "name")).to eq cert_2.other_name
      end
    end
  end

  context "when a user is not signed in" do
    it "returns an authentication error" do
      cert_attrs = OpenStruct.new(
        {
          other_name: "Other certification",
          issued_at: 1.year.ago
        }
      )

      arguments = [cert_attrs]

      mutation = build_mutation(arguments)

      result = gql_query(query: mutation, user: nil)
      error_code = result.fetch("errors").fetch(0).fetch("extensions").fetch("code")

      expect(error_code).to eq "AUTHENTICATION_ERROR"
    end
  end

  def build_inputs(attrs_array)
    attrs_array.map do |attrs|
      <<-GQL.strip_heredoc
        {
          otherName: "#{attrs.other_name}",
          issuedAt: "#{attrs.issued_at.iso8601}",
          #{optional_datetime('expiresAt', attrs.expires_at)}
        }
      GQL
    end.join(",")
  end

  def build_mutation(attrs_array)
    <<-GQL.strip_heredoc
    mutation {
      updateOtherCertifications(input: { certificationsAttributes: [#{build_inputs(attrs_array)}] })
      {
        otherCertifications {
          issuedAt
          name
          kind
        }
      }
    }
    GQL
  end
end
