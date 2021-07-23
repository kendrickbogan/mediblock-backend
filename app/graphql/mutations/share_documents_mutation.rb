# frozen_string_literal: true

module Mutations
  class ShareDocumentsMutation < Mutations::BaseMutation
    null true

    argument :sent_from_email, String, required: true
    argument :recipient_emails, [String], required: true
    argument :categories_included, [Types::DocumentCategoryEnum], required: true
    argument :document_ids, [ID], required: true

    field :sharing_event, Types::SharingEventType, null: true

    def resolve(sent_from_email:, recipient_emails:, categories_included:, document_ids:)
      if person.present?
        documents = person.documents.where(id: document_ids)
        sharing_event = person
          .sharing_events
          .create(
            sent_from_email: sent_from_email,
            recipient_emails: recipient_emails,
            categories_included: categories_included,
            documents: documents
          )

        if sharing_event.valid?
          { sharing_event: sharing_event }
        else
          { sharing_event: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
