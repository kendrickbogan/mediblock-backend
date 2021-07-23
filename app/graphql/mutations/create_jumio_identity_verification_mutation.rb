# frozen_string_literaL: true

module Mutations
  class CreateJumioIdentityVerificationMutation < Mutations::BaseMutation
    null true

    argument :jumio_scan_reference, String, required: true

    field :user, Types::UserType, null: true

    def resolve(jumio_scan_reference:)
      if current_user.present?
        verification = JumioIdentityVerification.create(
          user: current_user,
          scan_reference: jumio_scan_reference
        )

        if verification.valid?
          current_user.awaiting_verification!
          current_user.reload
          { user: current_user }
        else
          { user: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
