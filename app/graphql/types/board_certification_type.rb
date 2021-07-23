# frozen_string_literal: true

module Types
  class BoardCertificationType < Types::ObjectWithExpiration
    field :specialty, String, null: false
    field :specialty_rank, Types::SpecialtyRankEnum, null: false
    field :board_certified, Boolean, null: false
    field :certifying_board_name, String, null: true
    field :initial_certification_date, GraphQL::Types::ISO8601DateTime, null: false
    field :recertification_date, GraphQL::Types::ISO8601DateTime, null: false
    field :expires_at, GraphQL::Types::ISO8601DateTime, null: false
    field :board_certification_questionnaire, Types::BoardCertificationQuestionnaireType, null: true
  end
end
