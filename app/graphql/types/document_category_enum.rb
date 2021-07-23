# frozen_string_literal: true

module Types
  class DocumentCategoryEnum < Types::BaseEnum
    value "GENERAL_INFORMATION", value: "general_information"
    value "EDUCATION_AND_TRAINING", value: "education_and_training"
    value "BOARD_CERTIFICATION", value: "board_certification"
    value "PROFESSIONAL_LICENSE", value: "professional_license"
    value "PROFESSIONAL_LIABILITY_INSURANCE_DETAIL", value: "professional_liability_insurance_details"
    value "MEDICAL_LICENSING_EXAMINATION", value: "medical_licensing_examination"
    value "PEER_REFERENCE", value: "peer_reference"
    value "OTHER_CERTIFICATION", value: "other_certification"
    value "HOSPITAL_AFFILIATION", value: "hospital_affiliation"
    value "HEALTHCARE_FACILITY_AFFILIATION", value: "healthcare_facility_affiliation"
    value "ACADEMIC_APPOINTMENT", value: "academic_appointment"
    value "RESEARCH_AND_PUBLIC_BENEFIT_DATA", value: "research_and_public_benefit_data"
    value "PPD_OR_VACCINATION", value: "ppd_or_vaccination"
    value "EMPLOYMENT_HISTORY", value: "employment_history"
  end
end
