# frozen_string_literal: true

class PostGraduateTraining < ApplicationRecord
  belongs_to :person

  enum kind: { internship: 0, fellowship: 1, residency: 2 }

  validates :person,
            :kind,
            :attendance_start_date,
            presence: true

  validates :attendance_end_date,
            if: -> { successfully_completed_program },
            presence: true

  validates :acgme_accredited, inclusion: [true, false]
  validates :successfully_completed_program, inclusion: [true, false]

  def program_director_address
    [
      program_director_address_line_1,
      program_director_address_line_2,
      program_director_address_line_3,
      program_director_address_city,
      program_director_address_state,
      program_director_address_country,
      program_director_address_zip
    ].reject(&:blank?).join(", ")
  end
end
