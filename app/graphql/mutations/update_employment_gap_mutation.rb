# frozen_string_literaL: true

module Mutations
  class UpdateEmploymentGapMutation < Mutations::BaseMutation
    null true

    argument :text, String, required: true

    field :employment_gap, Types::EmploymentGapType, null: true

    def resolve(args)
      if person.present?
        employment_gap = person.employment_gap || EmploymentGap.new(person: person)
        employment_gap.update(args)

        if employment_gap.valid?
          { employment_gap: employment_gap }
        else
          { employment_gap: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
