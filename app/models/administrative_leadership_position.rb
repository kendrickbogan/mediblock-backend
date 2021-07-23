# frozen_string_literal: true

class AdministrativeLeadershipPosition < ApplicationRecord
  include StartAndEndValidations

  belongs_to :person

  validates :person, :started_at, presence: true

  def current?
    ended_at.nil? || Time.current < ended_at
  end
end
