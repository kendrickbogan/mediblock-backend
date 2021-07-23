# frozen_string_literal: true

module Mutations
  class UpdateProfessionalLicensesMutation < Mutations::BaseMutation
    null true

    argument :kind, Types::ProfessionalLicenseKind, required: true
    argument :professional_licenses_attributes, [Types::ProfessionalLicenseInput], required: true

    field :professional_licenses, [Types::ProfessionalLicenseType], null: true

    def resolve(professional_licenses_attributes:, kind:)
      if person.present?
        licenses = []
        ActiveRecord::Base.transaction do
          person.professional_licenses.public_send(kind).destroy_all
          licenses = build_attrs(professional_licenses_attributes, kind).map do |attrs|
            ProfessionalLicense.create(attrs.merge(person: person))
          end
        end

        if licenses.all?(&:valid?)
          { professional_licenses: licenses }
        else
          { professional_licenses: nil }
        end
      else
        raise_unauthenticated_error
      end
    end

    private

    def build_attrs(attributes, kind)
      attributes.map do |attrs|
        attrs.to_h.merge(kind: kind)
      end
    end
  end
end
