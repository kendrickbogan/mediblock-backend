# frozen_string_literal: true

module Mutations
  class DeleteHealthProfessionsScholarshipMutation < Mutations::BaseDeletionMutation
    def association_method
      :health_professions_scholarship
    end
  end
end
