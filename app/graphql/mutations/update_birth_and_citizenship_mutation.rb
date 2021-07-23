# frozen_string_literal: true

module Mutations
  class UpdateBirthAndCitizenshipMutation < Mutations::BaseMutation
    null true

    argument :date_of_birth, GraphQL::Types::ISO8601DateTime, required: true
    argument :place_of_birth_city, String, required: true
    argument :place_of_birth_state, String, required: false
    argument :place_of_birth_country, String, required: true
    argument :country_of_citizenship, String, required: true
    argument :us_permanent_resident, Boolean, required: false
    argument :visa_type, String, required: false
    argument :visa_number, String, required: false
    argument :visa_status, String, required: false
    argument :visa_expires_at, GraphQL::Types::ISO8601DateTime, required: false

    field :personal_details, Types::PersonType, null: true

    def resolve(birth_and_citizenship_attrs)
      if person.present?
        person.update(birth_and_citizenship_attrs)

        if person.valid?
          { personal_details: person }
        else
          { personal_details: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
