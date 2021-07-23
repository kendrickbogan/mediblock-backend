# frozen_string_literaL: true

module Mutations
  class UpdateNationalHealthServiceCorpsScholarshipMutation < Mutations::BaseMutation
    null true

    argument :started_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :ended_at, GraphQL::Types::ISO8601DateTime, required: true

    field :scholarship, Types::NationalHealthServiceCorpsScholarshipType, null: true

    def resolve(args)
      if person.present?
        scholarship = person.national_health_service_corps_scholarship || NationalHealthServiceCorpsScholarship.new(person: person)
        scholarship.update(args)

        if scholarship.valid?
          { scholarship: scholarship }
        else
          { scholarship: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
