# frozen_string_literaL: true

module Mutations
  class UpdateUserMutation < Mutations::BaseMutation
    null true

    argument :onboarding_status, Types::OnboardingStatusEnum, required: false
    argument :expiration_warning_time_units, Types::ExpirationWarningTimeUnitsEnum, required: false
    argument :expiration_warning_time, Integer, required: false

    field :user, Types::UserType, null: true

    def resolve(args)
      if current_user.present?
        current_user.update(args)

        if current_user.valid?
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
