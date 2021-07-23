# frozen_string_literal: true

module Types
  class ExpirationCategoryCount < Types::BaseObject
    field :id, Types::DocumentCategoryEnum, null: false
    field :count, Integer, null: false
  end
end
