# frozen_string_literal: true

module Types
  class CompletionStatusEnum < Types::BaseEnum
    value "NOT_STARTED", value: "not_started"
    value "IN_PROGRESS", value: "in_progress"
    value "COMPLETED", value: "completed"
    value "NOT_APPLICABLE", value: "not_applicable"
  end
end
