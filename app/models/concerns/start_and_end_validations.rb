# frozen_string_literal: true

module StartAndEndValidations
  extend ActiveSupport::Concern

  included do
    validate :start_before_end
    validate :end_after_start
  end

  private

  def start_before_end
    if ended_at.present? && started_at > ended_at
      errors.add(:started_at, "Start date should be before the end date")
    end
  end

  def end_after_start
    if ended_at.present? && ended_at < started_at
      errors.add(:ended_at, "End date should be after the start date")
    end
  end
end
