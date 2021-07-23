# frozen_string_literal: true

module Mutations
  class UpdateInfluenzaVaccinationMutation < Mutations::BaseMutation
    null true

    argument :vaccinated_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :facility_name, String, required: false
    argument :address_line_1, String, required: false
    argument :address_line_2, String, required: false
    argument :city, String, required: false
    argument :state, String, required: false
    argument :zip, String, required: false
    argument :has_been_vaccinated, Boolean, required: true
    argument :no_vaccination_comment, String, required: false
    argument :flu_season, String, required: false

    field :influenza_vaccination, Types::InfluenzaVaccinationType, null: true

    def resolve(args)
      if person.present?
        vaccination = person.influenza_vaccination || InfluenzaVaccination.new(person: person)
        vaccination.update(args)

        if vaccination.valid?
          { influenza_vaccination: vaccination }
        else
          { influenza_vaccination: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
