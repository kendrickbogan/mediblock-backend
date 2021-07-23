# frozen_string_literal: true

module Mutations
  class SignUpMutation < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true

    field :user, Types::UserType, null: false

    def resolve(email:, password:, first_name:, last_name:)
      user = User.create(email: email, password: password)
      person = Person.create(
        first_name: first_name,
        last_name: last_name,
        user: user
      )

      if user.valid? && person.valid?
        { user: user }
      end
    end
  end
end
