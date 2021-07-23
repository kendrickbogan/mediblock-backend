# frozen_string_literal: true

module Mutations
  class UpdateInsurancePoliciesMutation < Mutations::BaseMutation
    null true

    argument :insurance_policies_attributes, [Types::InsurancePolicyInput], required: true

    field :insurance_policies, [Types::InsurancePolicyType], null: true

    def resolve(insurance_policies_attributes:)
      if person.present?
        ActiveRecord::Base.transaction do
          person.insurance_policies.destroy_all
          person.insurance_policies_attributes = insurance_policies_attributes.map(&:to_h)
          person.save
        end

        if person.valid?
          { insurance_policies: person.insurance_policies }
        else
          { insurance_policies: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
