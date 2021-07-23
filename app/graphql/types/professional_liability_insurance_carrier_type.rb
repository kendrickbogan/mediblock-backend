# frozen_string_literal: true

module Types
  class ProfessionalLiabilityInsuranceCarrierType < Types::BaseObject
    field :malpractice_type, String, null: true

    field :organization_name, String, null: false
    field :organization_address_line_1, String, null: true
    field :organization_address_line_2, String, null: true
    field :organization_city, String, null: true
    field :organization_state, String, null: true
    field :organization_zip, String, null: true
    field :organization_phone_number, String, null: true
    field :organization_email_address, String, null: true
    field :organization_fax_number, String, null: true

    field :contact_person_first_name, String, null: true
    field :contact_person_last_name, String, null: true
    field :contact_person_role, String, null: true
    field :contact_person_phone_number, String, null: true
    field :contact_person_email_address, String, null: true
    field :contact_person_fax_number, String, null: true
  end
end
