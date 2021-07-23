# frozen_string_literal: true

module Mutations
  class UpdateProfessionalLiabilityInsuranceCarrierMutation < Mutations::BaseMutation
    null true

    argument :malpractice_type, String, required: false
    argument :organization_name, String, required: false
    argument :organization_address_line_1, String, required: false
    argument :organization_address_line_2, String, required: false
    argument :organization_city, String, required: false
    argument :organization_state, String, required: false
    argument :organization_zip, String, required: false
    argument :organization_phone_number, String, required: false
    argument :organization_email_address, String, required: false
    argument :organization_fax_number, String, required: false

    argument :contact_person_first_name, String, required: false
    argument :contact_person_last_name, String, required: false
    argument :contact_person_role, String, required: false
    argument :contact_person_phone_number, String, required: false
    argument :contact_person_email_address, String, required: false
    argument :contact_person_fax_number, String, required: false

    field :professional_liability_insurance_carrier, Types::ProfessionalLiabilityInsuranceCarrierType, null: true

    def resolve(args)
      if person.present?
        insurance = person.professional_liability_insurance_carrier || ProfessionalLiabilityInsuranceCarrier.new(person: person)
        insurance.update(args)

        if insurance.valid?
          { professional_liability_insurance_carrier: insurance }
        else
          { professional_liability_insurance_carrier: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end
