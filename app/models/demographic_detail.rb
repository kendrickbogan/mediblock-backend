# frozen_string_literal: true

class DemographicDetail < ApplicationRecord
  RACES = {
    white: "white",
    black_or_african_american: "black_or_african_american",
    american_indian_or_alaska_native: "american_indian_or_alaska_native",
    asian: "asian",
    native_hawaiian_or_other_pacific_islander: "native_hawaiian_or_other_pacific_islander"
  }.freeze

  belongs_to :person

  serialize :race, Array

  enum ethnicity: { not_hispanic_or_latino: 0, hispanic_or_latino: 1 }

  validates :ethnicity, presence: true
  validate :valid_races

  private

  def valid_races
    race.each do |value|
      if invalid_race_value?(value)
        errors.add(:race, "#{value} is not a valid value for race")
      end
    end
  end

  def invalid_race_value?(value)
    !RACES.values.include?(value)
  end
end
