class SharedDocumentMailerPreview < ActionMailer::Preview
  def share_document_email
    sharing_event = SharingEvent.first
    SharedDocumentMailer.with(sharing_event: sharing_event).share_document_email
  end
end
