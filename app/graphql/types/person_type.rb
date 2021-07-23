# frozen_string_literal: true

module Types
  class PersonType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :middle_name, String, null: true
    field :maiden_name, String, null: true
    field :suffix, String, null: true

    field :legal_gender, Types::LegalGender, null: false

    field :provider_profession_type, String, null: true

    field :social_security_number, String, null: true
    field :npi_number, String, null: true
    field :personal_medicare_number, String, null: true
    field :personal_medicaid_number, String, null: true
    field :upin_number, String, null: true
    field :orcid_id, String, null: true
    field :researcher_id, String, null: true
    field :scopus_author_id, String, null: true

    field :cell_phone_number, String, null: true
    field :emergency_contact_number, String, null: true

    field :home_address_line_1, String, null: true
    field :home_address_line_2, String, null: true
    field :home_address_line_3, String, null: true
    field :home_address_city, String, null: true
    field :home_address_state, String, null: true
    field :home_address_zip, String, null: true
    field :home_address_country, String, null: true
    field :mailing_address_same_as_home, Boolean, null: false
    field :mailing_address_line_1, String, null: true
    field :mailing_address_line_2, String, null: true
    field :mailing_address_line_3, String, null: true
    field :mailing_address_city, String, null: true
    field :mailing_address_state, String, null: true
    field :mailing_address_zip, String, null: true
    field :mailing_address_country, String, null: true

    field :date_of_birth, GraphQL::Types::ISO8601DateTime, null: true
    field :place_of_birth_city, String, null: true
    field :place_of_birth_state, String, null: true
    field :place_of_birth_country, String, null: true
    field :country_of_citizenship, String, null: true
    field :us_permanent_resident, Boolean, null: true
    field :visa_type, String, null: true
    field :visa_number, String, null: true
    field :visa_status, String, null: true
    field :visa_expires_at, GraphQL::Types::ISO8601DateTime, null: true

    field :academic_appointments, [Types::AcademicAppointmentType], null: false
    field :administrative_leadership_positions, [Types::AdministrativeLeadershipPositionType], null: false
    field :cme_credit_hours, [Types::CMECreditHourType], null: false
    field :covid_vaccination, Types::COVIDVaccinationType, null: true
    field :dea_license, Types::DEALicenseType, null: true
    field :demographic_detail, Types::DemographicDetailType, null: true
    field :drivers_license, Types::DriversLicenseType, null: true
    field :employment_gap, Types::EmploymentGapType, null: true
    field :health_professions_scholarship, Types::HealthProfessionsScholarshipType, null: true
    field :healthcare_facility_affiliations, [Types::HealthcareFacilityAffiliationType], null: false
    field :hospital_affiliations, [Types::HospitalAffiliationType], null: false
    field :influenza_vaccination, Types::InfluenzaVaccinationType, null: true
    field :insurance_policies, [Types::InsurancePolicyType], null: false
    field :loan_repayment_detail, Types::LoanRepaymentDetailType, null: true
    field :malpractice_claims, [Types::MalpracticeClaimType], null: false
    field :medical_degree, Types::MedicalDegreeType, null: true
    field :medical_group_employers, [Types::MedicalGroupEmployerType], null: false
    field :national_health_service_corps_scholarship, Types::NationalHealthServiceCorpsScholarshipType, null: true
    field :passport, Types::PassportType, null: true
    field :ppd_tuberculosis_testing, Types::PPDTuberculosisTestingType, null: true
    field :primary_certification, Types::BoardCertificationType, null: true
    field :prior_names, [Types::PriorNameType], null: false
    field :professional_liability_insurance_carrier, ProfessionalLiabilityInsuranceCarrierType, null: true
    field :professional_liability_judgments_questionnaire, Types::ProfessionalLiabilityJudgmentsQuestionnaireType,
          null: true
    field :secondary_certification, Types::BoardCertificationType, null: true
    field :spoken_languages, [Types::SpokenLanguageType], null: false
    field :united_states_public_health_service, Types::UnitedStatesPublicHealthServiceType, null: true

    field :board_certification,
          Types::BoardCertificationType,
          null: true,
          description: "Fetch board certification details for the given specialty rank" do
            argument :specialty_rank, Types::SpecialtyRankEnum, required: true
          end

    def board_certification(specialty_rank:)
      certification_type = "#{specialty_rank}_certification"
      object.public_send(certification_type)
    end

    field :certification, Types::CertificationType, null: true do
      argument :kind, Types::CertificationKindEnum, required: true
    end

    def certification(kind:)
      object.certifications.public_send(kind).first
    end

    field :comlex_usa_scores, Types::COMLEXUSAScoreType, null: true

    def comlex_usa_scores
      object.comlex_usa_score
    end

    field :degree,
          Types::DegreeType,
          null: true,
          description: "Fetch degree details for the given kind" do
            argument :kind, Types::DegreeKind, required: true
          end

    def degree(kind:)
      object.public_send("#{kind}_degree")
    end

    field :documents, [Types::DocumentType], null: false do
      argument :category, Types::DocumentCategoryEnum, required: false
      argument :profile_section, Types::ProfileSectionEnum, required: false
    end

    def documents(category: nil, profile_section: nil)
      scope = object.documents.not_deleted

      if category.present?
        scope = scope.where(category: category)
      end

      if profile_section.present?
        scope = scope.where(profile_section: profile_section)
      end

      scope
    end

    field :document, Types::DocumentType, null: true do
      argument :id, ID, required: true
    end

    def document(id:)
      object
        .documents
        .not_deleted
        .find_by(id: id)
    end

    field :military_service, Types::MilitaryServiceType, null: true

    def military_service
      object.military_service_detail
    end

    field :other_certifications, [Types::CertificationType], null: false

    def other_certifications
      object.certifications.other
    end

    field :peer_reference, Types::PeerReferenceType, null: true do
      argument :position, Integer, required: true
    end

    def peer_reference(position:)
      object.peer_references.find_by(position: position)
    end

    field :post_graduate_training,
          Types::PostGraduateTrainingType,
          null: true,
          description: "Fetch post graduate training details for the given kind" do
            argument :kind, Types::PostGraduateTrainingKind, required: true
          end

    def post_graduate_training(kind:)
      object.public_send(kind)
    end

    field :professional_licenses, [Types::ProfessionalLicenseType], null: false do
      argument :kind, Types::ProfessionalLicenseKind, required: true
    end

    def professional_licenses(kind:)
      object.professional_licenses.public_send(kind)
    end

    field :sharing_event, Types::SharingEventType, null: true do
      argument :id, ID, required: true
    end

    def sharing_event(id:)
      object.sharing_events.find_by(id: id)
    end

    field :sharing_events, [Types::SharingEventType], null: false

    def sharing_events
      object.sharing_events.order(created_at: :desc)
    end

    field :usmle_scores, Types::USMLEScoreType, null: true

    def usmle_scores
      object.usmle_score
    end

    field :expirations, [Types::ExpirationType], null: false do
      argument :kind, Types::ExpirationKindEnum, required: true
      argument :category, Types::DocumentCategoryEnum, required: false
    end

    def expirations(kind:, category: nil)
      scope = Expiration
        .expiring_within_threshold(current_user.expiration_warning_date)
        .where(person: object)
        .public_send("for_#{kind}s")

      if category.present?
        scope.where(category: category)
      else
        scope
      end
    end

    field :expirations_by_category, [Types::ExpirationCategoryCount], null: false

    def expirations_by_category
      ExpirationCountQuery
        .new(object)
        .by_category
        .map do |category_id, count|
          {
            id: category_id,
            count: count
          }
        end
    end

    field :expirations_by_profile_section, [Types::ExpirationProfileSectionCount], null: false

    def expirations_by_profile_section
      ExpirationCountQuery
        .new(object)
        .by_profile_section
        .map do |section_id, count|
          {
            id: section_id,
            count: count
          }
        end
    end

    field :form_completion, Types::FormCompletionType, null: true do
      argument :profile_section, Types::ProfileSectionEnum, required: true
    end

    def form_completion(profile_section:)
      object.form_completions.find_by(profile_section: profile_section)
    end

    field :form_completions, [Types::FormCompletionType], null: false do
      argument :profile_sections, [Types::ProfileSectionEnum], required: true
    end

    def form_completions(profile_sections:)
      object.form_completions.where(profile_section: profile_sections)
    end

    field :form_completion_by_category, [Types::FormCompletionCategoryCount], null: false

    def form_completion_by_category
      FormCompletion
        .where(person: object)
        .completed
        .group(:category)
        .count
        .map do |category, count|
          {
            id: category,
            count: count
          }
        end
    end

    private

    def current_user
      context[:current_user]
    end
  end
end
