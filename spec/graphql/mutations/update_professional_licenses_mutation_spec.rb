# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateProfessionalLicensesMutation do
  context "with a valid request" do
    context "with required argments" do
      it "updates and returns the list of created licenses" do
        person = create(:person)

        license_1 = OpenStruct.new(
          {
            issuing_state: CS.states(:US)[:MA],
            issuing_authority: "Mass Medical Authority",
            number: "564738193",
            date_of_issue: 1.year.ago,
            expires_at: 5.years.from_now,
            status: "Valid",
            unrestricted_license: true,
            license_verification_url: "http://something.com"
          }
        )
        license_2 = OpenStruct.new(
          {
            issuing_state: CS.states(:US)[:NJ],
            issuing_authority: "NJ Medical Authority",
            number: "123444444",
            date_of_issue: 1.year.ago,
            expires_at: 5.years.from_now,
            status: "Valid",
            unrestricted_license: true,
            license_verification_url: "http://something.com"
          }
        )

        arguments = [license_1, license_2]

        mutation = build_mutation(arguments, kind: "MEDICAL")

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateProfessionalLicenses")
        licenses = person.professional_licenses

        expect(licenses.length).to eq 2
        expect(data.dig("professionalLicenses", 0, "number")).to eq license_1.number
        expect(data.dig("professionalLicenses", 1, "number")).to eq license_2.number
      end

      it "handles OTHER license kind" do
        person = create(:person)

        license_1 = OpenStruct.new(
          {
            issuing_state: CS.states(:US)[:MA],
            issuing_authority: "Mass Medical Authority",
            number: "564738193",
            date_of_issue: 1.year.ago,
            expires_at: 5.years.from_now,
            status: "Valid",
            unrestricted_license: true,
            license_verification_url: "http://something.com",
            non_medical_license_kind: "License type"
          }
        )

        arguments = [license_1]

        mutation = build_mutation(arguments, kind: "OTHER")

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateProfessionalLicenses")

        expect(ProfessionalLicense.other.count).to eq 1
        expect(data.dig("professionalLicenses", 0, "number")).to eq license_1.number
      end

      it "handles XRAY_FLUOROSCOPY license kind" do
        person = create(:person)

        license_1 = OpenStruct.new(
          {
            issuing_state: CS.states(:US)[:MA],
            issuing_authority: "Mass Medical Authority",
            number: "564738193",
            date_of_issue: 1.year.ago,
            expires_at: 5.years.from_now,
            status: "Valid",
            unrestricted_license: true,
            license_verification_url: "http://something.com",
            non_medical_license_kind: "XRAY"
          }
        )

        arguments = [license_1]

        mutation = build_mutation(arguments, kind: "XRAY_FLUOROSCOPY")

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateProfessionalLicenses")

        expect(ProfessionalLicense.xray_fluoroscopy.count).to eq 1
        expect(data.dig("professionalLicenses", 0, "number")).to eq license_1.number
      end
    end
  end

  context "when a user is not signed in" do
    it "returns an authentication error" do
      license_1 = OpenStruct.new(
        {
          issuing_state: CS.states(:US)[:MA],
          issuing_authority: "Mass Medical Authority",
          number: "564738193",
          date_of_issue: 1.year.ago,
          expires_at: 5.years.from_now,
          status: "Valid",
          license_verification_url: "http://something.com",
          unrestricted_license: true
        }
      )

      arguments = [license_1]

      mutation = build_mutation(arguments, kind: "MEDICAL")

      result = gql_query(query: mutation, user: nil)
      error_code = result.fetch("errors").fetch(0).fetch("extensions").fetch("code")

      expect(error_code).to eq "AUTHENTICATION_ERROR"
    end
  end

  def build_inputs(attrs_array)
    attrs_array.map do |attrs|
      <<-GQL.strip_heredoc
        {
          issuingState: "#{attrs.issuing_state}",
          issuingAuthority: "#{attrs.issuing_authority}",
          number: "#{attrs.number}",
          dateOfIssue: "#{attrs.date_of_issue.iso8601}",
          expiresAt: "#{attrs.expires_at.iso8601}",
          status: "#{attrs.status}",
          unrestrictedLicense: #{attrs.unrestricted_license},
          licenseVerificationUrl: "#{attrs.license_verification_url}",
          #{optional_string('nonMedicalLicenseKind', attrs.non_medical_license_kind)}
        }
      GQL
    end.join(",")
  end

  def build_mutation(attrs_array, kind:)
    <<-GQL.strip_heredoc
    mutation {
      updateProfessionalLicenses(input: {
        professionalLicensesAttributes: [#{build_inputs(attrs_array)}],
        kind: #{kind}
      })
      {
        professionalLicenses {
          number
        }
      }
    }
    GQL
  end
end
