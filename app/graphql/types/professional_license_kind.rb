# frozen_string_literal: true

module Types
  class ProfessionalLicenseKind < Types::BaseEnum
    value "MEDICAL", value: "medical"
    value "XRAY_FLUOROSCOPY", value: "xray_fluoroscopy"
    value "OTHER", value: "other"
  end
end
