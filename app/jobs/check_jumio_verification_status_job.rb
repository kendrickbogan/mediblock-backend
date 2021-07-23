# frozen_string_literal: true

class CheckJumioVerificationStatusJob < ApplicationJob
  class JumioVerificationCheckFailed < StandardError; end

  retry_on(
    JumioVerificationCheckFailed, ActiveRecord::RecordNotFound,
    wait: :exponentially_longer,
    attempts: 3
  )

  def perform(scan_reference)
    @scan = JumioIdentityVerification.find(scan_reference)
    return unless @scan.pending?

    response = HTTParty.get(
      retrieve_scan_details_url,
      basic_auth: basic_auth_creds,
      headers: {
        Accept: "application/json",
        "User-Agent": "Mediblock MediblockID/v1.0"
      }
    )

    verification_status = response["status"]

    if response.ok? && verification_status.present?
      if verification_status == JumioIdentityVerification::APPROVED_STATUS
        @scan.verified!
        @scan.user.onboarding_complete!
      else
        @scan.update(verification_status: verification_status.downcase)
        @scan.user.identity_verification_failed!
      end
    else
      raise JumioVerificationCheckFailed, "#{response.code}: #{response.message}"
    end
  end

  private

  def basic_auth_creds
    { username: ENV.fetch("JUMIO_API_TOKEN"), password: ENV.fetch("JUMIO_API_SECRET") }
  end

  def retrieve_scan_details_url
    "https://netverify.com/api/netverify/v2/scans/#{@scan.scan_reference}/data/document"
  end
end
