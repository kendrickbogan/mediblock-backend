# frozen_string_literaL: true

module Mutations
  class UpdateUSMLEScoresMutation < Mutations::BaseMutation
    null true

    argument :usmle_id_number, String, required: false

    argument :step_1_exam_passed, Boolean, required: true
    argument :step_1_exam_score, String, required: true
    argument :step_1_exam_date, GraphQL::Types::ISO8601DateTime, required: true

    argument :step_2_exam_passed, Boolean, required: true
    argument :step_2_exam_score, String, required: true
    argument :step_2_exam_date, GraphQL::Types::ISO8601DateTime, required: true

    argument :step_3_exam_passed, Boolean, required: true
    argument :step_3_exam_score, String, required: true
    argument :step_3_exam_date, GraphQL::Types::ISO8601DateTime, required: true

    field :usmle_scores, Types::USMLEScoreType, null: true

    def resolve(args)
      if person.present?
        usmle_scores = person.usmle_score || USMLEScore.new(person: person)
        usmle_scores.update(args)

        if usmle_scores.valid?
          { usmle_scores: usmle_scores }
        else
          { usmle_scores: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
