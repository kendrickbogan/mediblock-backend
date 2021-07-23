# frozen_string_literal: true

module Types
  class DocumentType < Types::ObjectWithExpiration
    field :attachment, Types::AttachmentType, null: false
    field :category, Types::DocumentCategoryEnum, null: false
    field :expires_at, GraphQL::Types::ISO8601DateTime, null: true
    field :id, ID, null: false
    field :kind, Types::DocumentKindEnum, null: false
    field :name, String, null: false
    field :other_kind, String, null: true
    field :person, Types::PersonType, null: false
    field :profile_section, Types::ProfileSectionEnum, null: false
  end
end
