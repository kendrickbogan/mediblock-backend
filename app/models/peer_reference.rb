# frozen_string_literal: true

class PeerReference < ApplicationRecord
  belongs_to :person

  validates :person, presence: true

  # The position field is being used on the front end to determine which peer
  # reference to fetch, e.g., Peer Reference #1 or Peer Reference #3.
  validates :position, presence: true, uniqueness: { scope: :person_id }

  def address
    [
      address_line_1,
      address_line_2,
      city,
      state,
      zip,
      country
    ].reject(&:blank?).join(", ")
  end
end
