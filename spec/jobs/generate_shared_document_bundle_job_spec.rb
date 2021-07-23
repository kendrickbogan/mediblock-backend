require "rails_helper"

RSpec.describe GenerateSharedDocumentBundleJob do
  describe ".perform" do
    it "invokes CreateSharedDocumentBundle" do
      allow(CreateSharedDocumentBundle).to receive(:perform)
      sharing_event = create(:sharing_event)

      GenerateSharedDocumentBundleJob.perform_now(sharing_event.id)

      expect(CreateSharedDocumentBundle).to have_received(:perform).with(sharing_event)
    end

    it "enqueues SharedDocumentMailer" do
      sharing_event = create(:sharing_event)

      expect do
        GenerateSharedDocumentBundleJob.perform_now(sharing_event.id)
      end.to have_enqueued_mail(SharedDocumentMailer, :share_document_email)
    end
  end
end
