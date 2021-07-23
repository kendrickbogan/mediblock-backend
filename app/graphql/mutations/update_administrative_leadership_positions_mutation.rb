# frozen_string_literal: true

module Mutations
  class UpdateAdministrativeLeadershipPositionsMutation < Mutations::BaseMutation
    null true

    argument :administrative_leadership_positions_attributes,
             [Types::AdministrativeLeadershipPositionsInputType],
             required: true

    field :administrative_leadership_positions,
          [Types::AdministrativeLeadershipPositionType],
          null: true

    def resolve(administrative_leadership_positions_attributes:)
      if person.present?
        ActiveRecord::Base.transaction do
          person.administrative_leadership_positions.destroy_all
          person.administrative_leadership_positions_attributes = administrative_leadership_positions_attributes.map(&:to_h)
          person.save
        end

        if person.valid?
          { administrative_leadership_positions: person.administrative_leadership_positions }
        else
          { administrative_leadership_positions: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
