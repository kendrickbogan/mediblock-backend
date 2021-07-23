# frozen_string_literal: true

module Mutations
  class DeleteDocumentMutation < Mutations::BaseMutation
    null true

    argument :id, ID, required: true

    field :id, ID, null: true

    def resolve(id:)
      if person.present?
        document = person.documents.find(id)
        document.update(deleted: true)

        { id: document.id }
      else
        raise_unauthenticated_error
      end
    rescue ActiveRecord::RecordNotFound
      { id: nil }
    end
  end
end
