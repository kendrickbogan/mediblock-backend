# frozen_string_literal: true

class Certification < ApplicationRecord
  include ExpirableItem

  expirable_category CATEGORIES[:OTHER_CERTIFICATION]

  belongs_to :person

  enum kind: {
    ACLS: 0,
    ATLS: 1,
    BLS: 2,
    CPR: 3,
    CoreC: 4,
    NALS: 5,
    NRP: 6,
    PALS: 7,
    other: 8
  }

  validates :person, :issued_at, :kind, presence: true
  validates :other_name, presence: true, if: -> { other? }

  def name
    other? ? other_name : kind
  end

  def profile_section
    other? ? PROFILE_SECTIONS[:OTHER_CERTIFICATION] : PROFILE_SECTIONS[kind.upcase.to_sym]
  end
end
