# frozen_string_literal: true

module Mutations
  class UpdateCOVIDVaccinationMutation < Mutations::BaseMutation
    null true

    argument :vaccination_date_1, GraphQL::Types::ISO8601DateTime, required: true
    argument :vaccination_date_2, GraphQL::Types::ISO8601DateTime, required: false
    argument :facility_name, String, required: false
    argument :address_line_1, String, required: false
    argument :address_line_2, String, required: false
    argument :city, String, required: false
    argument :state, String, required: false
    argument :zip, String, required: false

    field :covid_vaccination, Types::COVIDVaccinationType, null: true

    def resolve(args)
      if person.present?
        vaccination = person.covid_vaccination || COVIDVaccination.new(person: person)
        vaccination.update(args)

        if vaccination.valid?
          { covid_vaccination: vaccination }
        else
          { covid_vaccination: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
