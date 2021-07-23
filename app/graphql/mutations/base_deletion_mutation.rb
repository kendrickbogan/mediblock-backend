# frozen_string_literal: true

module Mutations
  class BaseDeletionMutation < Mutations::MutationWithoutInput
    null true

    field :success, Boolean, null: false

    def association_method
      raise "Subclass must implement"
    end

    def resolve
      if person.nil?
        raise_unauthenticated_error
      elsif person.public_send(association_method)&.destroy
        { success: true }
      else
        { success: false }
      end
    end
  end
end
