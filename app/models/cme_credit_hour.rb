# frozen_string_literal: true

class CMECreditHour < ApplicationRecord
  belongs_to :person

  validates :person, :activity_date, presence: true

  validates :hours_earned,
            presence: true,
            numericality: { greater_than: 0 }
end
