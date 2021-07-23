# frozen_string_literaL: true

module Mutations
  class UpdatePassportMutation < Mutations::BaseMutation
    null true

    argument :country_of_issue, String, required: false
    argument :expires_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :number, String, required: false

    field :passport, Types::PassportType, null: true

    def resolve(args)
      if person.present?
        passport = person.passport || Passport.new(person: person)
        passport.update(args)

        if passport.valid?
          { passport: passport }
        else
          { passport: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
