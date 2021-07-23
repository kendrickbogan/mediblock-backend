# frozen_string_literal: true

module Types
  class SharingEventType < Types::BaseObject
    field :id, ID, null: false
    field :person, Types::PersonType, null: false
    field :sent_from_email, String, null: false
    field :recipient_emails, [String], null: false
    field :categories_included, [Types::DocumentCategoryEnum], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :documents, [Types::DocumentType], null: false
    field :document_sent, Boolean, null: false

    def document_sent
      object.zip_file.attached?
    end
  end
end
