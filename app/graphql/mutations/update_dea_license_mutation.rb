# frozen_string_literal: true

module Mutations
  class UpdateDEALicenseMutation < Mutations::BaseMutation
    null true

    argument :registration_number, String, required: true
    argument :expires_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :status, String, required: true
    argument :unrestricted, Boolean, required: true

    field :dea_license, Types::DEALicenseType, null: true

    def resolve(dea_license_attrs)
      if person.present?
        license = person.dea_license || DEALicense.new(person: person)
        license.update(dea_license_attrs)

        if license.valid?
          { dea_license: license }
        else
          { dea_license: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
