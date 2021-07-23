# frozen_string_literal: true

class NationalHealthServiceCorpsScholarship < ApplicationRecord
  include StartAndEndValidations
  belongs_to :person
end
