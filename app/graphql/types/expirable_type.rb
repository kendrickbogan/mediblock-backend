# frozen_string_literal: true

module Types
  class ExpirableType < Types::BaseUnion
    description "Objects which have may have an expiration date"
    possible_types(
      Types::BoardCertificationType,
      Types::CertificationType,
      Types::DEALicenseType,
      Types::DocumentType,
      Types::DriversLicenseType,
      Types::PassportType,
      Types::ProfessionalLicenseType
    )
  end
end
