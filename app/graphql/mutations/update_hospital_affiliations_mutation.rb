# frozen_string_literal: true

module Mutations
  class UpdateHospitalAffiliationsMutation < Mutations::BaseMutation
    null true

    argument :hospital_affiliations_attributes, [Types::HospitalAffiliationInput], required: true

    field :hospital_affiliations, [Types::HospitalAffiliationType], null: true

    def resolve(hospital_affiliations_attributes:)
      if person.present?
        ActiveRecord::Base.transaction do
          person.hospital_affiliations&.destroy_all
          person.hospital_affiliations_attributes = hospital_affiliations_attributes.map(&:to_h)
          person.save
        end

        if person.valid?
          { hospital_affiliations: person.hospital_affiliations }
        else
          { hospital_affiliations: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
