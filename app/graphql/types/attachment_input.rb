# frozen_string_literal: true

module Types
  class AttachmentInput < Types::BaseInputObject
    description "Input to create or edit document attachments"
    argument :data, String, required: true
  end
end
