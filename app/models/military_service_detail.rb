# frozen_string_literal: true

class MilitaryServiceDetail < ApplicationRecord
  include StartAndEndValidations

  belongs_to :person

  validates :person, :started_at, presence: true

  validates :has_dd214, inclusion: [true, false]

  def active_duty?
    ended_at.nil?
  end
end
