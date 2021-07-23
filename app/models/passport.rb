# frozen_string_literal: true

class Passport < ApplicationRecord
  include ExpirableItem

  expirable_category CATEGORIES[:GENERAL_INFORMATION]
  expirable_profile_section PROFILE_SECTIONS[:PASSPORT]

  belongs_to :person

  validates :person, presence: true
end
