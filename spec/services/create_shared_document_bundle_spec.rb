require "rails_helper"

RSpec.describe CreateSharedDocumentBundle do
  describe ".perform" do
    it "generates a zip file containing the event's attached document and a PDF" do
      document = create(:document)
      sharing_event = create(:sharing_event, documents: [document])

      zip_file = CreateSharedDocumentBundle.perform(sharing_event)

      file_names = []
      Zip::InputStream.open(zip_file) do |io|
        while entry = io.get_next_entry
          file_names << entry.name
        end
      end

      expect(file_names.size).to eq 2
      expect(
        file_names.any? { |name| name.match?(document.bundle_filename) }
      ).to be true
      expect(
        file_names.any? { |name| name.match?(/.pdf/) }
      ).to be true
    end
  end
end
