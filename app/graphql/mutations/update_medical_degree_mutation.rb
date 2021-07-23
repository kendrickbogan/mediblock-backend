# frozen_string_literal: true

module Mutations
  class UpdateMedicalDegreeMutation < Mutations::BaseMutation
    null true

    argument :institution_name, String, required: false
    argument :kind, Types::MedicalDegreeKind, required: true
    argument :date_of_graduation, GraphQL::Types::ISO8601DateTime, required: true
    argument :started_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :ended_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :registrar_phone_number, String, required: false
    argument :registrar_url, String, required: false
    argument :foreign_medical_school, Boolean, required: true
    argument :ecfmg_certified, Boolean, required: true
    argument :ecfmg_certified_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :institution_address_line_1, String, required: false
    argument :institution_address_line_2, String, required: false
    argument :institution_address_line_3, String, required: false
    argument :institution_address_city, String, required: false
    argument :institution_address_state, String, required: false
    argument :institution_address_zip, String, required: false
    argument :institution_address_country, String, required: false

    field :medical_degree, Types::MedicalDegreeType, null: true

    def resolve(medical_degree_attrs)
      if person.present?
        medical_degree = person.medical_degree || MedicalDegree.new(person: person)
        updated_attrs = update_medical_degree_attrs(medical_degree_attrs)
        medical_degree.update(updated_attrs)

        if medical_degree.valid?
          { medical_degree: medical_degree }
        else
          { medical_degree: nil }
        end
      else
        raise_unauthenticated_error
      end
    end

    def update_medical_degree_attrs(attrs)
      if attrs[:ecfmg_certified]
        attrs
      else
        attrs.merge({ ecfmg_certified_at: nil })
      end
    end
  end
end
