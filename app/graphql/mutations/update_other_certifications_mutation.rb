# frozen_string_literal: true

module Mutations
  class UpdateOtherCertificationsMutation < Mutations::BaseMutation
    null true

    argument :certifications_attributes, [Types::OtherCertificationInput], required: true

    field :other_certifications, [Types::CertificationType], null: true

    def resolve(certifications_attributes:)
      if person.present?
        certifications = []

        ActiveRecord::Base.transaction do
          person.certifications.other.destroy_all
          certifications = build_attrs(certifications_attributes).map do |attrs|
            Certification.create(attrs.merge(person: person))
          end
        end

        if certifications.all?(&:valid?)
          { other_certifications: certifications }
        else
          { other_certifications: nil }
        end
      else
        raise_unauthenticated_error
      end
    end

    private

    def build_attrs(input_attrs)
      input_attrs.map do |attrs|
        attrs.to_h.merge(kind: "other")
      end
    end
  end
end
