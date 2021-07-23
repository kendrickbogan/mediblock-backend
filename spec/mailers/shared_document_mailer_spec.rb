require "rails_helper"

RSpec.describe SharedDocumentMailer do
  describe "#share_document_email" do
    it "includes a link to the shared document" do
      event = create(:sharing_event)
      mail = SharedDocumentMailer.with(sharing_event: event).share_document_email

      expect(mail.body.encoded).to include(sharing_event_url(event.uuid))
    end
  end
end
