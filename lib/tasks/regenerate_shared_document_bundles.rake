desc "Regenerate shared document bundles"
task regenerate_shared_document_bundles: :environment do
  ActiveStorage::Attachment.where(record_type: "SharingEvent").destroy_all
  SharingEvent.find_each do |sharing_event|
    CreateSharedDocumentBundle.perform(sharing_event)
  end
end
