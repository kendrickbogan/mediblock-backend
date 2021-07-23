# frozen_string_literal: true

class DEALicense < ApplicationRecord
  include ExpirableItem

  expirable_category CATEGORIES[:PROFESSIONAL_LICENSE]
  expirable_profile_section PROFILE_SECTIONS[:DEA_LICENSE]

  belongs_to :person

  validates :person, presence: true
  validates :unrestricted, inclusion: [true, false]
end
