# frozen_string_literal: true

module Types
  class AttachmentType < Types::ObjectWithExpiration
    field :id, ID, null: false
    field :url, String, null: false
    field :preview_url, String, null: false
    field :content_type, String, null: false

    def preview_url
      object
        .representation(resize_to_limit: [500, 500])
        .processed
        .url
    end
  end
end
