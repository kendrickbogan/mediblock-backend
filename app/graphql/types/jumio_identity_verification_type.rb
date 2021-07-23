# frozen_string_literal: true

module Types
  class JumioIdentityVerificationType < Types::BaseObject
    field :scan_reference, String, null: false
    field :user, Types::UserType, null: false
    field :verification_status, Types::VerificationStatusEnum, null: false
  end
end
