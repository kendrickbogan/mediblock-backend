# frozen_string_literaL: true

module Mutations
  class UpdateCOMLEXScoresMutation < Mutations::BaseMutation
    null true

    argument :nbome_id_number, String, required: false

    argument :level_1_passed, Boolean, required: true
    argument :level_1_score, Integer, required: false
    argument :level_1_exam_date, GraphQL::Types::ISO8601DateTime, required: false

    argument :level_2_ce_passed, Boolean, required: true
    argument :level_2_ce_score, Integer, required: false
    argument :level_2_ce_exam_date, GraphQL::Types::ISO8601DateTime, required: false

    argument :level_2_pe_passed, Boolean, required: true
    argument :level_2_pe_score, Integer, required: false
    argument :level_2_pe_exam_date, GraphQL::Types::ISO8601DateTime, required: false

    argument :level_3_passed, Boolean, required: true
    argument :level_3_score, Integer, required: false
    argument :level_3_exam_date, GraphQL::Types::ISO8601DateTime, required: false

    field :comlex_scores, Types::COMLEXUSAScoreType, null: true

    def resolve(args)
      if person.present?
        scores = person.comlex_usa_score || COMLEXUSAScore.new(person: person)
        scores.update(args)

        if scores.valid?
          { comlex_scores: scores }
        else
          { comlex_scores: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
