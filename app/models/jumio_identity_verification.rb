# frozen_string_literal: true

class JumioIdentityVerification < ApplicationRecord
  self.primary_key = "scan_reference"

  VERIFICATION_LIMIT = 3
  APPROVED_STATUS = "APPROVED_VERIFIED"

  after_create :enqueue_verification_result_check
  after_commit :enforce_verification_attempt_limit

  belongs_to :user

  validates :user, :scan_reference, presence: true
  validate :verification_limit

  enum verification_status: {
    pending: 0,
    approved_verified: 1,
    denied_fraud: 2,
    denied_unsupported_id_type: 3,
    denied_unsupported_id_country: 4,
    error_not_readable_id: 5,
    no_id_uploaded: 6
  }

  def verified!
    approved_verified!
  end

  def verified?
    approved_verified?
  end

  def failed?
    !pending? && !verified?
  end

  private

  def enqueue_verification_result_check
    CheckJumioVerificationStatusJob
      .set(wait: 3.minutes)
      .perform_later(scan_reference)
  end

  def enforce_verification_attempt_limit
    if user.jumio_identity_verifications.count == VERIFICATION_LIMIT
      user.verification_attempts_exceeded!
    end
  end

  def verification_limit
    if user.jumio_identity_verifications.count >= VERIFICATION_LIMIT
      errors.add(:retry_limit, "Users cannot create more than #{VERIFICATION_LIMIT} verifications")
    end
  end
end
