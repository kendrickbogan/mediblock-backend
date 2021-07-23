# frozen_string_literal: true

module Mutations
  class SignOutMutation < Mutations::MutationWithoutInput
    field :success, Boolean, null: false

    def resolve
      user = context[:current_user]

      if user.present? && user.reset_remember_token!
        { success: true }
      else
        { success: false }
      end
    end
  end
end
