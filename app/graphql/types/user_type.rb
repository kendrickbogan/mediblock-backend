# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :authorization_token, String, null: false
    field :onboarding_status, Types::OnboardingStatusEnum, null: false
    field :person, Types::PersonType, null: false
    field :verification_attempts, Integer, null: false
    field :last_verification, Types::JumioIdentityVerificationType, null: true
    field :expiration_warning_time, Integer, null: false
    field :expiration_warning_time_units, Types::ExpirationWarningTimeUnitsEnum, null: false

    def authorization_token
      object.remember_token
    end

    def verification_attempts
      jumio_verifications.count
    end

    def last_verification
      jumio_verifications.order(created_at: :desc).first
    end

    private

    def jumio_verifications
      object.jumio_identity_verifications
    end
  end
end
