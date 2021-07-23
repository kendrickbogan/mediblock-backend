# frozen_string_literal: true

module Mutations
  class UpdateMalpracticeClaimsMutation < Mutations::BaseMutation
    null true

    argument :malpractice_claims_attributes, [Types::MalpracticeClaimInput], required: true

    field :malpractice_claims, [Types::MalpracticeClaimType], null: true

    def resolve(malpractice_claims_attributes:)
      if person.present?
        ActiveRecord::Base.transaction do
          person.malpractice_claims.destroy_all
          person.malpractice_claims_attributes = malpractice_claims_attributes.map(&:to_h)
          person.save
        end

        if person.valid?
          { malpractice_claims: person.malpractice_claims }
        else
          { malpractice_claims: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
