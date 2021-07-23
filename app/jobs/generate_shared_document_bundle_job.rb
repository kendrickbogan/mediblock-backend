# frozen_string_literal: true

class GenerateSharedDocumentBundleJob < ApplicationJob
  def perform(sharing_event_id)
    sharing_event = SharingEvent.find(sharing_event_id)
    CreateSharedDocumentBundle.perform(sharing_event)
    SharedDocumentMailer
      .with(sharing_event: sharing_event)
      .share_document_email
      .deliver_later
  end
end
