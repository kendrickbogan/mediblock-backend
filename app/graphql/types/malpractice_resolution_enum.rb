# frozen_string_literal: true

module Types
  class MalpracticeResolutionEnum < Types::BaseEnum
    value "DISMISSED", value: "dismissed"
    value "SETTLED_WITH_PREJUDICE", value: "settled_with_prejudice"
    value "SETTLED_WITHOUT_PREJUDICE", value: "settled_without_prejudice"
    value "JUDGEMENT_FOR_PLANTIFF", value: "judgement_for_plantiff"
    value "JUDGEMENT_FOR_DEFENDANT", value: "judgement_for_defendant"
    value "MEDIATION_OR_ARBITRATION", value: "mediation_or_arbitration"
    value "OTHER", value: "other"
  end
end
