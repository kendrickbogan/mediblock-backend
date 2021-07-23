# frozen_string_literal: true

module GraphqlSupport
  def gql_query(query:, user: nil, variables: {}, context: {})
    context[:current_user] ||= user

    query = GraphQL::Query.new(
      MediblockIdSchema,
      query,
      variables: variables.deep_stringify_keys,
      context: context
    )

    query.result.to_h
  end

  def optional_integer(arg_name, value)
    optional_non_string(arg_name, value)
  end

  def optional_enum(arg_name, value)
    optional_non_string(arg_name, value)
  end

  def optional_string(arg_name, value)
    "#{arg_name}: \"#{value}\"," unless value.nil?
  end

  def optional_datetime(arg_name, value)
    "#{arg_name}: \"#{value.iso8601}\"," unless value.nil?
  end

  private

  def optional_non_string(arg_name, value)
    "#{arg_name}: #{value}," unless value.nil?
  end
end

RSpec.configure do |config|
  config.include GraphqlSupport, type: :gql
end
