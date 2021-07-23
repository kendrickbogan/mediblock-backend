# frozen_string_literal: true

class LoanRepaymentDetail < ApplicationRecord
  include StartAndEndValidations

  belongs_to :person

  validates :person,
            presence: true

  def institution_address
    [
      address_line_1,
      address_line_2,
      address_line_3,
      city,
      state,
      zip
    ].reject(&:blank?).join(", ")
  end
end
