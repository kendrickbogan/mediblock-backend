# frozen_string_literal: true

class PPDTuberculosisTesting < ApplicationRecord
  belongs_to :person

  enum ppd_interpretation: [:negative, :positive]

  validates :person, presence: true

  validates :had_positive_tb_skin_test,
            :tested_more_than_5_years_ago,
            :received_bcg_vaccine,
            :had_tb_disease_diagnosis,
            :has_taken_inh_or_rifampin,
            :treatment_completed_more_than_5_years_ago,
            :tested_in_the_last_year,
            inclusion: [true, false]

  validates :test_reaction_size,
            :last_chest_xray_at,
            if: :had_positive_tb_skin_test?,
            presence: true

  validate :conditional_date_presence, if: :had_positive_tb_skin_test?

  def testing_site_address
    [
      address_line_1,
      address_line_2,
      city,
      state,
      zip
    ].reject(&:blank?).join(", ")
  end

  private

  def conditional_date_presence
    if tested_positive_at.blank? && !tested_more_than_5_years_ago?
      errors.add(:tested_positive_at, "can't be blank")
    end

    if year_tested_positive.blank? && tested_more_than_5_years_ago?
      errors.add(:year_tested_positive, "can't be blank")
    end

    if treatment_completed_at_required?
      errors.add(:treatment_completed_at, "can't be blank")
    end

    if year_treatment_completed_required?
      errors.add(:year_treatment_completed, "can't be blank")
    end
  end

  def treatment_completed_at_required?
    treatment_completed_at.blank? &&
      !treatment_completed_more_than_5_years_ago &&
      has_taken_inh_or_rifampin
  end

  def year_treatment_completed_required?
    year_treatment_completed.blank? &&
      treatment_completed_more_than_5_years_ago &&
      has_taken_inh_or_rifampin
  end
end
