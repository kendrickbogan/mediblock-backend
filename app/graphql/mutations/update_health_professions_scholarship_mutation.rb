# frozen_string_literal: true

module Mutations
  class UpdateHealthProfessionsScholarshipMutation < Mutations::BaseMutation
    null true

    argument :military_branch_scholarship_sponsor, String, required: false
    argument :started_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :ended_at, GraphQL::Types::ISO8601DateTime, required: true

    field :health_professions_scholarship, Types::HealthProfessionsScholarshipType, null: true

    def resolve(attrs)
      if person.present?
        health_professions_scholarship = person.health_professions_scholarship || HealthProfessionsScholarship.new(person: person)
        health_professions_scholarship.update(attrs)

        if health_professions_scholarship.valid?
          { health_professions_scholarship: health_professions_scholarship }
        else
          { health_professions_scholarship: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
