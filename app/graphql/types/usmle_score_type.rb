# frozen_string_literaL: true

module Types
  class USMLEScoreType < Types::BaseObject
    field :person, Types::PersonType, null: false
    field :usmle_id_number, String, null: false

    field :step_1_exam_passed, Boolean, null: true
    field :step_1_exam_score, String, null: true
    field :step_1_exam_date, GraphQL::Types::ISO8601DateTime, null: true

    field :step_2_exam_passed, Boolean, null: true
    field :step_2_exam_score, String, null: true
    field :step_2_exam_date, GraphQL::Types::ISO8601DateTime, null: true

    field :step_3_exam_passed, Boolean, null: true
    field :step_3_exam_score, String, null: true
    field :step_3_exam_date, GraphQL::Types::ISO8601DateTime, null: true
  end
end
