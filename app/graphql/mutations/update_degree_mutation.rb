# frozen_string_literal: true

module Mutations
  class UpdateDegreeMutation < Mutations::BaseMutation
    null true

    argument :institution_name, String, required: false
    argument :kind, Types::DegreeKind, required: true
    argument :degree, String, required: false
    argument :major, String, required: false
    argument :minor, String, required: false
    argument :date_of_graduation, GraphQL::Types::ISO8601DateTime, required: true
    argument :started_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :ended_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :registrar_phone_number, String, required: false
    argument :registrar_url, String, required: false
    argument :institution_address_line_1, String, required: false
    argument :institution_address_line_2, String, required: false
    argument :institution_address_line_3, String, required: false
    argument :institution_address_city, String, required: false
    argument :institution_address_state, String, required: false
    argument :institution_address_zip, String, required: false
    argument :institution_address_country, String, required: false

    field :degree, Types::DegreeType, null: true

    def resolve(degree_attrs)
      if person.present?
        degree_kind = "#{degree_attrs[:kind]}_degree"
        degree = person.public_send(degree_kind) || Degree.new(person: person)
        degree.update(degree_attrs)

        if degree.valid?
          { degree: degree }
        else
          { degree: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
