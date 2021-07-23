# frozen_string_literaL: true

module Mutations
  class UpdateUnitedStatesPublicHealthServiceMutation < Mutations::BaseMutation
    null true

    argument :started_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :ended_at, GraphQL::Types::ISO8601DateTime, required: false

    field :service, Types::UnitedStatesPublicHealthServiceType, null: true

    def resolve(args)
      if person.present?
        service = person.united_states_public_health_service || UnitedStatesPublicHealthService.new(person: person)
        service.update(args)

        if service.valid?
          { service: service }
        else
          { service: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
