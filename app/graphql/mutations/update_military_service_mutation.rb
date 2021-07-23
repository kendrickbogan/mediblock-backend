# frozen_string_literal: true

module Mutations
  class UpdateMilitaryServiceMutation < Mutations::BaseMutation
    null true

    argument :branch_of_service, String, required: false
    argument :started_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :ended_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :active_duty, Boolean, required: true
    argument :has_dd214, Boolean, required: true

    field :military_service, Types::MilitaryServiceType, null: true

    def resolve(args)
      if person.present?
        military_service_detail = person.military_service_detail || MilitaryServiceDetail.new(person: person)
        update_attributes = build_update_attributes(args)
        military_service_detail.update(update_attributes)

        if military_service_detail.valid?
          { military_service: military_service_detail }
        else
          { military_service: nil }
        end
      else
        raise_unauthenticated_error
      end
    end

    def build_update_attributes(attributes)
      {
        branch_of_service: attributes[:branch_of_service],
        started_at: attributes[:started_at],
        ended_at: attributes[:active_duty] ? nil : attributes[:ended_at],
        has_dd214: attributes[:has_dd214]
      }
    end
  end
end
