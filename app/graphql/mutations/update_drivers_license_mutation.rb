# frozen_string_literal: true

module Mutations
  class UpdateDriversLicenseMutation < Mutations::BaseMutation
    null true

    argument :number, String, required: false
    argument :issuing_state, String, required: false
    argument :expires_at, GraphQL::Types::ISO8601DateTime, required: true

    field :drivers_license, Types::DriversLicenseType, null: true

    def resolve(args)
      if person.present?
        drivers_license = person.drivers_license || DriversLicense.new(person: person)
        drivers_license.update(args)

        if drivers_license.valid?
          { drivers_license: drivers_license }
        else
          { drivers_license: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
