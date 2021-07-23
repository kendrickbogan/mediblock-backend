# frozen_string_literal: true

module Types
  class FormCompletionType < Types::BaseObject
    field :id, ID, null: false
    field :profile_section, Types::ProfileSectionEnum, null: false
    field :category, Types::DocumentCategoryEnum, null: false
    field :status, Types::CompletionStatusEnum, null: false
  end
end
