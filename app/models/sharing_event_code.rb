class SharingEventCode < ApplicationRecord
  EXPIRATION_HOURS = 1

  belongs_to :sharing_event

  before_validation :generate_code, on: :create

  validates :sharing_event, presence: true
  validates :email, presence: true
  validates :code, presence: true, uniqueness: true
  validate :email_in_sharing_event_recipients

  scope :valid, -> { where("created_at >= ?", EXPIRATION_HOURS.hours.ago) }
  scope :expired, -> { where("created_at < ?", EXPIRATION_HOURS.hours.ago) }

  def expired?
    created_at <= EXPIRATION_HOURS.hours.ago
  end

  private

  def email_in_sharing_event_recipients
    unless sharing_event.recipient_emails.include?(email)
      errors.add(:email, "Must be included in the sharing event's recipients")
    end
  end

  def generate_code
    loop do
      self.code = SecureRandom.hex(3).upcase
      break unless SharingEventCode.where(code: code).exists?
    end
  end
end
