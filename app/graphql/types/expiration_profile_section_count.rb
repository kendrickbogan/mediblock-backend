# frozen_string_literal: true

module Types
  class ExpirationProfileSectionCount < Types::BaseObject
    field :id, Types::ProfileSectionEnum, null: true
    field :count, Integer, null: false
  end
end
