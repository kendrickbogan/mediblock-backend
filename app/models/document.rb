class Document < ApplicationRecord
  include ExpirableItem

  belongs_to :person
  has_and_belongs_to_many :sharing_events

  before_destroy { sharing_events.clear }

  PERMITTED_CONTENT_TYPES = [
    "application/pdf",
    "image/jpeg",
    "image/jpg",
    "image/png"
  ].freeze

  has_one_base64_attached :attachment

  time_for_a_boolean :deleted

  enum category: CATEGEGORY_ENUM
  enum kind: DOCUMENT_KIND_ENUM, _suffix: "document_type"
  enum profile_section: PROFILE_SECTIONS_ENUM, _suffix: "profile_section"

  validates :name, :category, :person, :attachment, presence: true
  validates :attachment, content_type: PERMITTED_CONTENT_TYPES
  validates :other_kind, presence: true, if: -> { other_document_type? }

  scope :not_deleted, -> { where("deleted_at IS NULL OR deleted_at > ?", Time.now) }
  scope :deleted, -> { where("deleted_at IS NOT NULL AND deleted_at <= ?", Time.now) }

  def bundle_filename
    # When generating file names for the document bundle, we're unable to use
    # the attachment's file name because it doesn't preserve the file extension.
    # Grabbing the file extension from the contet type will only work for
    # certain mime types (e.g., images and pdfs). If we expand the support
    # attachment types, we should find a better way to generate file names.
    file_extension = attachment
      .content_type
      .partition("/")
      .last

    "#{name.parameterize}.#{file_extension}"
  end
end
