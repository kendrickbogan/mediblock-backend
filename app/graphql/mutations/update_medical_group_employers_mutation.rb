# frozen_string_literal: true

module Mutations
  class UpdateMedicalGroupEmployersMutation < Mutations::BaseMutation
    null true

    argument :medical_group_employers_attributes, [Types::MedicalGroupEmployerInput], required: true

    field :medical_group_employers, [Types::MedicalGroupEmployerType], null: true

    def resolve(medical_group_employers_attributes:)
      if person.present?
        ActiveRecord::Base.transaction do
          person.medical_group_employers&.destroy_all
          person.medical_group_employers_attributes = medical_group_employers_attributes.map(&:to_h)
          person.save
        end

        if person.valid?
          { medical_group_employers: person.medical_group_employers }
        else
          { medical_group_employers: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
