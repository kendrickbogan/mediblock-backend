# frozen_string_literal: true

module Types
  class OnboardingStatusEnum < Types::BaseEnum
    value "ACCOUNT_CREATED", value: "account_created"
    value "AWAITING_VERIFICATION", value: "awaiting_verification"
    value "IDENTITY_VERIFIED", value: "identity_verified"
    value "IDENTITY_VERIFICATION_FAILED", value: "identity_verification_failed"
    value "VERIFICATION_ATTEMPTS_EXCEEDED", value: "verification_attempts_exceeded"
    value "ONBOARDING_COMPLETE", value: "onboarding_complete"
  end
end
