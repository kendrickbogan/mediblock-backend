# frozen_string_literal: true

class JumioIdentityVerificationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :verify_jumio_ip_address

  def create
    verification = JumioIdentityVerification.find(params["jumioIdScanReference"])
    verification.update(verification_status: params["verificationStatus"].downcase)

    if verification.verified?
      verification.user.onboarding_complete!
    else
      verification.user.identity_verification_failed!
    end

    head :ok
  end

  private

  def verify_jumio_ip_address
    unless jumio_ip_addresses.include? request.remote_ip
      head :unauthorized
    end
  end

  def jumio_ip_addresses
    Resolv.getaddresses("callback.jumio.com")
  end
end
