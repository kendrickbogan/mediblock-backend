# frozen_string_literal: true

module Mutations
  class UpdateAddressesMutation < Mutations::BaseMutation
    null true

    argument :home_address_line_1, String, required: false
    argument :home_address_line_2, String, required: false
    argument :home_address_line_3, String, required: false
    argument :home_address_city, String, required: false
    argument :home_address_state, String, required: false
    argument :home_address_zip, String, required: false
    argument :home_address_country, String, required: false
    argument :mailing_address_same_as_home, Boolean, required: true
    argument :mailing_address_line_1, String, required: false
    argument :mailing_address_line_2, String, required: false
    argument :mailing_address_line_3, String, required: false
    argument :mailing_address_city, String, required: false
    argument :mailing_address_state, String, required: false
    argument :mailing_address_zip, String, required: false
    argument :mailing_address_country, String, required: false

    field :personal_details, Types::PersonType, null: true

    def resolve(address_attributes)
      if person.present?
        person.assign_attributes(address_attributes)
        person.clear_mailing_address if address_attributes[:mailing_address_same_as_home]
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
