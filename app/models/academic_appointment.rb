# frozen_string_literal: true

class AcademicAppointment < ApplicationRecord
  include StartAndEndValidations

  belongs_to :person

  validates :person,
            :started_at,
            :institution_name,
            :address_line_1,
            :city,
            :zip,
            presence: true

  validates :country, presence: true, inclusion: CS.countries.values

  validates :state, inclusion: CS.states(:US).values, if: -> { state.present? }

  def current?
    ended_at.nil? || Time.current < ended_at
  end

  def department_head_full_name
    [department_head_first_name, department_head_last_name].join(" ")
  end

  def full_address
    [
      address_line_1,
      address_line_2,
      city,
      state,
      zip,
      country
    ].reject(&:blank?).join(", ")
  end
end
