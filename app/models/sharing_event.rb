# frozen_string_literal: true

class SharingEvent < ApplicationRecord
  belongs_to :person
  has_and_belongs_to_many :documents
  has_many :codes, class_name: "SharingEventCode", dependent: :destroy

  before_destroy { documents.clear }

  has_one_attached :zip_file

  validates :person, :sent_from_email, presence: true
  validates :recipient_emails,
            length: {
              minimum: 1,
              message: "You must include at least one recipient"
            }
  validate :category_is_allowed

  after_create :enqueue_sharing_job

  private

  def category_is_allowed
    return if categories_included.empty?

    invalid_categories = categories_included.reject { |item| allowed_categories.include? item }
    if invalid_categories.present?
      errors.add(:items_included, "#{invalid_categories.to_sentence} are not valid categories to include")
    end
  end

  def allowed_categories
    CATEGORIES.values.map(&:to_s)
  end

  def enqueue_sharing_job
    GenerateSharedDocumentBundleJob.perform_later(id)
  end
end
