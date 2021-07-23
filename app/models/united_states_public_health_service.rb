# frozen_string_literal: true

class UnitedStatesPublicHealthService < ApplicationRecord
  include StartAndEndValidations
  belongs_to :person
end
