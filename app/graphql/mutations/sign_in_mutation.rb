# frozen_string_literal: true

module Mutations
  class SignInMutation < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true

    def resolve(email:, password:)
      user = User.authenticate(email, password)

      if user.present?
        { user: user }
      end
    end
  end
end
