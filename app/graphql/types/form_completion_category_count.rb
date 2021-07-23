# frozen_string_literal: true

module Types
  class FormCompletionCategoryCount < Types::BaseObject
    field :id, Types::DocumentCategoryEnum, null: false
    field :count, Integer, null: false
  end
end
