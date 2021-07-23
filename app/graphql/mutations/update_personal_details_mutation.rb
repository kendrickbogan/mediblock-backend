# frozen_string_literal: true

module Mutations
  class UpdatePersonalDetailsMutation < Mutations::BaseMutation
    null true

    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :middle_name, String, required: false
    argument :maiden_name, String, required: false
    argument :suffix, String, required: false

    argument :provider_profession_type, String, required: false

    argument :legal_gender, Types::LegalGender, required: true

    argument :cell_phone_number, String, required: false
    argument :emergency_contact_number, String, required: false

    field :personal_details, Types::PersonType, null: true

    def resolve(person_attributes)
      if current_user
        person = current_user.person || Person.new(user: current_user)
        person.assign_attributes(person_attributes)
        person.save

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
