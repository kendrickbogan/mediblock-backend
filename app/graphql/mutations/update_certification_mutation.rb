# frozen_string_literal: true

module Mutations
  class UpdateCertificationMutation < Mutations::BaseMutation
    null true

    argument :kind, Types::CertificationKindEnum, required: true
    argument :issued_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :expires_at, GraphQL::Types::ISO8601DateTime, required: false

    field :certification, Types::CertificationType, null: true

    def resolve(attrs)
      if person.present?
        ActiveRecord::Base.transaction do
          Certification.where(person: person, kind: attrs[:kind]).destroy_all
          certification = Certification.create(attrs.merge(person: person))

          if certification.valid?
            { certification: certification }
          else
            { certification: nil }
          end
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
