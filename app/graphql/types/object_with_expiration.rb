module Types
  class ObjectWithExpiration < Types::BaseObject
    field :expires_within_timeframe, Boolean, null: false

    def expires_within_timeframe
      expires_at.present? && expires_at < Expiration.expiration_warning_date
    end
  end
end
