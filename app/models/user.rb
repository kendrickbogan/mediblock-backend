# frozen_string_literal: true

class User < ApplicationRecord
  include Clearance::User

  has_one :person, dependent: :destroy
  has_many :jumio_identity_verifications, dependent: :destroy

  delegate :full_name, to: :person

  enum onboarding_status: {
    account_created: 0,
    awaiting_verification: 5,
    identity_verified: 10,
    identity_verification_failed: 11,
    verification_attempts_exceeded: 12,
    onboarding_complete: 20
  }

  enum expiration_warning_time_units: {
    weeks: "weeks",
    months: "months"
  }

  validates :expiration_warning_time, numericality: true

  def expiration_warning_date
    expiration_warning_time
      .public_send(expiration_warning_time_units)
      .from_now
  end
end
