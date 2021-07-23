# frozen_string_literal: true

module Types
  class COMLEXUSAScoreType < Types::BaseObject
    field :person, Types::PersonType, null: false

    field :nbome_id_number, String, null: false

    field :level_1_passed, Boolean, null: false
    field :level_1_score, Integer, null: true
    field :level_1_exam_date, GraphQL::Types::ISO8601DateTime, null: true

    field :level_2_ce_passed, Boolean, null: false
    field :level_2_ce_score, Integer, null: true
    field :level_2_ce_exam_date, GraphQL::Types::ISO8601DateTime, null: true

    field :level_2_pe_passed, Boolean, null: false
    field :level_2_pe_score, Integer, null: true
    field :level_2_pe_exam_date, GraphQL::Types::ISO8601DateTime, null: true

    field :level_3_passed, Boolean, null: false
    field :level_3_score, Integer, null: true
    field :level_3_exam_date, GraphQL::Types::ISO8601DateTime, null: true
  end
end
