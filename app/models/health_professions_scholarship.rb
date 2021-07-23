# frozen_string_literal: true

class HealthProfessionsScholarship < ApplicationRecord
  include StartAndEndValidations

  belongs_to :person

  validates :started_at,
            :ended_at,
            presence: true
end
