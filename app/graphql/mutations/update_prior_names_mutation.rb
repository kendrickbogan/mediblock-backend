# frozen_string_literal: true

module Mutations
  class UpdatePriorNamesMutation < Mutations::BaseMutation
    null true

    argument :prior_names_attributes, [Types::PriorNameInput], required: true

    field :prior_names, [Types::PriorNameType], null: true

    def resolve(prior_names_attributes:)
      if person.present?
        ActiveRecord::Base.transaction do
          person.prior_names.destroy_all
          person.prior_names_attributes = prior_names_attributes.map(&:to_h)
          person.save
        end

        if person.valid?
          { prior_names: person.prior_names }
        else
          { prior_names: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
