# frozen_string_literal: true

class DriversLicense < ApplicationRecord
  include ExpirableItem

  expirable_category CATEGORIES[:GENERAL_INFORMATION]
  expirable_profile_section PROFILE_SECTIONS[:DRIVERS_LICENSE]

  belongs_to :person

  validates :person, presence: true
end
