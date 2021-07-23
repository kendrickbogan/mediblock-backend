module AuthenticationHelpers
  def current_user
    context[:current_user]
  end

  def person
    current_user&.person
  end

  def raise_unauthenticated_error
    raise GraphQL::ExecutionError.new(
      "You must be signed in to view this information",
      extensions: { code: "AUTHENTICATION_ERROR" }
    )
  end
end
