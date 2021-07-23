# frozen_string_literal: true

module Mutations
  class UpdateSpokenLanguagesMutation < Mutations::BaseMutation
    null true

    argument :spoken_languages_attributes, [Types::SpokenLanguageInput], required: true

    field :spoken_languages, [Types::SpokenLanguageType], null: true

    def resolve(spoken_languages_attributes:)
      if person.present?
        ActiveRecord::Base.transaction do
          person.spoken_languages.destroy_all
          person.spoken_languages_attributes = spoken_languages_attributes.map(&:to_h)
          person.save
        end

        if person.valid?
          { spoken_languages: person.spoken_languages }
        else
          { spoken_languages: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
