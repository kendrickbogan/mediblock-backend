# frozen_string_literal: true

module Mutations
  class CreateDocumentMutation < Mutations::BaseMutation
    null true

    argument :attachment, Types::AttachmentInput, required: true
    argument :category, Types::DocumentCategoryEnum, required: true
    argument :expires_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :kind, Types::DocumentKindEnum, required: true
    argument :name, String, required: true
    argument :other_kind, String, required: false
    argument :profile_section, Types::ProfileSectionEnum, required: true

    field :document, Types::DocumentType, null: true

    def resolve(args)
      if person.present?
        document = Document.create(
          person: person,
          name: args[:name],
          category: args[:category],
          expires_at: args[:expires_at],
          kind: args[:kind],
          other_kind: args[:other_kind],
          attachment: args[:attachment].to_h,
          profile_section: args[:profile_section]
        )

        if document.valid?
          { document: document }
        else
          { document: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
