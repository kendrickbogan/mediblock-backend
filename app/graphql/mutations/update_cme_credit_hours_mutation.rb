# frozen_string_literal: true

module Mutations
  class UpdateCMECreditHoursMutation < Mutations::BaseMutation
    null true

    argument :cme_credit_hours_attributes, [Types::CMECreditHourInput], required: true

    field :cme_credit_hours, [Types::CMECreditHourType], null: true

    def resolve(cme_credit_hours_attributes:)
      if person.present?
        ActiveRecord::Base.transaction do
          person.cme_credit_hours.destroy_all
          person.cme_credit_hours_attributes = cme_credit_hours_attributes.map(&:to_h)
          person.save
        end

        if person.valid?
          { cme_credit_hours: person.cme_credit_hours }
        else
          { cme_credit_hours: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
