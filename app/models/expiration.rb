# frozen_string_literal: true

class Expiration < ApplicationRecord
  belongs_to :expirable, polymorphic: true
  belongs_to :person

  enum category: CATEGEGORY_ENUM, _suffix: "category"
  enum profile_section: PROFILE_SECTIONS_ENUM, _suffix: "profile_section"

  validates :expirable, :expires_at, :person, presence: true
  validate :person_owns_expirable

  scope :for_documents, -> { where(expirable_type: "Document") }
  scope :for_forms, -> { where.not(expirable_type: "Document") }
  scope :expiring_within_threshold,
        lambda { |expiration_warning_date|
          where("expires_at IS NOT NULL AND expires_at <= ?", expiration_warning_date)
        }

  private

  def person_owns_expirable
    person == expirable.person
  end
end
