# frozen_string_literaL: true

class USMLEScore < ApplicationRecord
  belongs_to :person

  validates :person, presence: true
end
