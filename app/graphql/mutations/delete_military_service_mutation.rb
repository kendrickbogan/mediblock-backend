# frozen_string_literal: true

module Mutations
  class DeleteMilitaryServiceMutation < Mutations::BaseDeletionMutation
    def association_method
      :military_service_detail
    end
  end
end
