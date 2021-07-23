# frozen_string_literal: true

module Mutations
  class UpdateHealthcareFacilityAffiliationsMutation < Mutations::BaseMutation
    null true

    argument :healthcare_facility_affiliations_attributes, [Types::HealthcareFacilityAffiliationInput], required: true

    field :healthcare_facility_affiliations, [Types::HealthcareFacilityAffiliationType], null: true

    def resolve(healthcare_facility_affiliations_attributes:)
      if person.present?
        ActiveRecord::Base.transaction do
          person.healthcare_facility_affiliations&.destroy_all
          person.healthcare_facility_affiliations_attributes = healthcare_facility_affiliations_attributes.map(&:to_h)
          person.save
        end

        if person.valid?
          { healthcare_facility_affiliations: person.healthcare_facility_affiliations }
        else
          { healthcare_facility_affiliations: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
