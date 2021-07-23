# frozen_string_literal: true

module Mutations
  class DeleteUnitedStatesPublicHealthServiceMutation < Mutations::BaseDeletionMutation
    def association_method
      :united_states_public_health_service
    end
  end
end
