# frozen_string_literal: true

module Mutations
  class UpdateDocumentMutation < Mutations::BaseMutation
    null true

    argument :attachment, Types::AttachmentInput, required: false
    argument :category, Types::DocumentCategoryEnum, required: true
    argument :expires_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :id, ID, required: true
    argument :kind, Types::DocumentKindEnum, required: true
    argument :name, String, required: true
    argument :other_kind, String, required: false
    argument :profile_section, Types::ProfileSectionEnum, required: true

    field :document, Types::DocumentType, null: true

    def resolve(args)
      if person.present?
        document = person.documents.find(args[:id])
        document.update(
          name: args[:name],
          category: args[:category],
          expires_at: args[:expires_at],
          kind: args[:kind],
          other_kind: args[:other_kind],
          profile_section: args[:profile_section]
        )

        if args[:attachment].present?
          document.update(attachment: args[:attachment].to_h)
        end

        if document.valid?
          { document: document }
        else
          empty_document_response
        end
      else
        raise_unauthenticated_error
      end
    rescue ActiveRecord::RecordNotFound
      empty_document_response
    end

    def empty_document_response
      { document: nil }
    end
  end
end
