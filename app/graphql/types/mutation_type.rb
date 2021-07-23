# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_document, mutation: Mutations::CreateDocumentMutation
    field :create_jumio_identity_verification, mutation: Mutations::CreateJumioIdentityVerificationMutation

    field :delete_document, mutation: Mutations::DeleteDocumentMutation
    field :delete_loan_repayment_detail, mutation: Mutations::DeleteLoanRepaymentDetailMutation
    field :delete_military_service, mutation: Mutations::DeleteMilitaryServiceMutation
    field :delete_nation_health_service_corps_scholarship,
          mutation: Mutations::DeleteNationHealthServiceCorpsScholarshipMutation
    field :delete_united_states_public_health_service,
          mutation: Mutations::DeleteUnitedStatesPublicHealthServiceMutation
    field :delete_health_professions_scholarship,
          mutation: Mutations::DeleteHealthProfessionsScholarshipMutation

    field :share_documents, mutation: Mutations::ShareDocumentsMutation
    field :sign_in, mutation: Mutations::SignInMutation
    field :sign_up, mutation: Mutations::SignUpMutation
    field :sign_out, mutation: Mutations::SignOutMutation

    field :update_academic_appointments, mutation: Mutations::UpdateAcademicAppointmentsMutation
    field :update_addresses, mutation: Mutations::UpdateAddressesMutation
    field :update_administrative_leadership_positions,
          mutation: Mutations::UpdateAdministrativeLeadershipPositionsMutation
    field :update_birth_and_citizenship, mutation: Mutations::UpdateBirthAndCitizenshipMutation
    field :update_board_certification, mutation: Mutations::UpdateBoardCertificationMutation
    field :update_certification, mutation: Mutations::UpdateCertificationMutation
    field :update_cme_credit_hours, mutation: Mutations::UpdateCMECreditHoursMutation
    field :update_comlex_scores, mutation: Mutations::UpdateCOMLEXScoresMutation
    field :update_covid_vaccination, mutation: Mutations::UpdateCOVIDVaccinationMutation
    field :update_dea_license, mutation: Mutations::UpdateDEALicenseMutation
    field :update_degree, mutation: Mutations::UpdateDegreeMutation
    field :update_demographic_detail, mutation: Mutations::UpdateDemographicDetailMutation
    field :update_document, mutation: Mutations::UpdateDocumentMutation
    field :update_drivers_license, mutation: Mutations::UpdateDriversLicenseMutation
    field :update_employment_gap, mutation: Mutations::UpdateEmploymentGapMutation
    field :update_form_completion_status, mutation: Mutations::UpdateFormCompletionStatusMutation
    field :update_health_professions_scholarship, mutation: Mutations::UpdateHealthProfessionsScholarshipMutation
    field :update_healthcare_facility_affiliations, mutation: Mutations::UpdateHealthcareFacilityAffiliationsMutation
    field :update_hospital_affiliations, mutation: Mutations::UpdateHospitalAffiliationsMutation
    field :update_id_numbers, mutation: Mutations::UpdateIdNumbersMutation
    field :update_influenza_vaccination, mutation: Mutations::UpdateInfluenzaVaccinationMutation
    field :update_insurance_policies, mutation: Mutations::UpdateInsurancePoliciesMutation
    field :update_loan_repayment_detail, mutation: Mutations::UpdateLoanRepaymentDetailMutation
    field :update_malpractice_claims, mutation: Mutations::UpdateMalpracticeClaimsMutation
    field :update_medical_degree, mutation: Mutations::UpdateMedicalDegreeMutation
    field :update_medical_group_employers, mutation: Mutations::UpdateMedicalGroupEmployersMutation
    field :update_military_service, mutation: Mutations::UpdateMilitaryServiceMutation
    field :update_national_health_service_corps_scholarship,
          mutation: Mutations::UpdateNationalHealthServiceCorpsScholarshipMutation
    field :update_other_certifications, mutation: Mutations::UpdateOtherCertificationsMutation
    field :update_passport, mutation: Mutations::UpdatePassportMutation
    field :update_peer_reference, mutation: Mutations::UpdatePeerReferenceMutation
    field :update_personal_details, mutation: Mutations::UpdatePersonalDetailsMutation
    field :update_post_graduate_training, mutation: Mutations::UpdatePostGraduateTrainingMutation
    field :update_ppd_tuberculosis_testing, mutation: Mutations::UpdatePPDTuberculosisTestingMutation
    field :update_prior_names, mutation: Mutations::UpdatePriorNamesMutation
    field :update_professional_liability_insurance_carrier,
          mutation: Mutations::UpdateProfessionalLiabilityInsuranceCarrierMutation
    field :update_professional_liability_judgments_questionnaire,
          mutation: Mutations::UpdateProfessionalLiabilityJudgmentsQuestionnaireMutation
    field :update_professional_licenses, mutation: Mutations::UpdateProfessionalLicensesMutation
    field :update_spoken_languages, mutation: Mutations::UpdateSpokenLanguagesMutation
    field :update_united_states_public_health_service,
          mutation: Mutations::UpdateUnitedStatesPublicHealthServiceMutation
    field :update_user, mutation: Mutations::UpdateUserMutation
    field :update_usmle_scores, mutation: Mutations::UpdateUSMLEScoresMutation
  end
end
