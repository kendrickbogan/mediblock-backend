class PriorName < ApplicationRecord
  include StartAndEndValidations

  belongs_to :person

  validates :name, :started_at, :ended_at, presence: true
end
