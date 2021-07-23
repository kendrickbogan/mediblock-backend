# frozen_string_literal: true

module Mutations
  class UpdateIdNumbersMutation < Mutations::BaseMutation
    null true

    argument :npi_number, String, required: false
    argument :social_security_number, String, required: false
    argument :upin_number, String, required: false
    argument :personal_medicaid_number, String, required: false
    argument :personal_medicare_number, String, required: false
    argument :orcid_id, String, required: false
    argument :researcher_id, String, required: false
    argument :scopus_author_id, String, required: false

    field :personal_details, Types::PersonType, null: true

    def resolve(id_number_attributes)
      if person.present?
        person.update(id_number_attributes)

        if person.valid?
          { personal_details: person }
        else
          { personal_details: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
