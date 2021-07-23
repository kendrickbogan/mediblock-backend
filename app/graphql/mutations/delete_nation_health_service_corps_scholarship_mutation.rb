# frozen_string_literal: true

module Mutations
  class DeleteNationHealthServiceCorpsScholarshipMutation < Mutations::BaseDeletionMutation
    def association_method
      :national_health_service_corps_scholarship
    end
  end
end
