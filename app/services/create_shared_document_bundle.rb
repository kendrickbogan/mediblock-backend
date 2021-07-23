# frozen_string_literal: true

require "zip"

class CreateSharedDocumentBundle
  def self.perform(share_event)
    new(share_event).perform
  end

  def initialize(share_event)
    @share_event = share_event
  end

  def perform
    zip_file = generate_zip_file
    @share_event.zip_file.attach(
      io: zip_file,
      filename: "#{base_file_name}.zip",
      content_type: "application/zip"
    )
    zip_file
  end

  private

  def person
    @share_event.person
  end

  def base_file_name
    date = @share_event.created_at.strftime("%m_%d_%y")
    person_name = "#{person.first_name}_#{person.last_name}"
    "#{person_name}-mediblock_share-#{date}"
  end

  def pdf_file_name
    "#{base_file_name}.pdf"
  end

  def shared_documents
    @share_event.documents.map do |document|
      attachment = document.attachment

      attachment_file = Tempfile.new(document.bundle_filename, binmode: true)
      attachment_file.write(attachment.download)
      attachment_file.rewind

      OpenStruct.new(
        filename: document.bundle_filename,
        file: attachment_file
      )
    end
  end

  def profile_information_pdf_file
    file = Tempfile.new("tmp/#{pdf_file_name}", binmode: true)
    pdf_data = PdfGenerators::ProfileInformation.new(@share_event).render
    file.write(pdf_data)
    file.rewind
    file
  end

  def generate_zip_file
    zip_file = Zip::OutputStream.write_buffer do |stream|
      shared_documents.each do |document|
        stream.put_next_entry document.filename
        stream.write IO.read(document.file)
      end

      stream.put_next_entry pdf_file_name
      stream.write IO.read(profile_information_pdf_file)
    end

    zip_file.rewind
    zip_file
  end
end
