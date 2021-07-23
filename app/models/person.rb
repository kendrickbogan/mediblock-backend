# frozen_string_literal: true

class Person < ApplicationRecord
  belongs_to :user

  has_one :comlex_usa_score, dependent: :destroy
  has_one :covid_vaccination, dependent: :destroy
  has_one :dea_license, dependent: :destroy
  has_one :demographic_detail, dependent: :destroy
  has_one :drivers_license, dependent: :destroy
  has_one :employment_gap, dependent: :destroy
  has_one :fellowship,
          -> { where(kind: "fellowship") },
          class_name: "PostGraduateTraining",
          dependent: :destroy
  has_one :health_professions_scholarship, dependent: :destroy
  has_one :influenza_vaccination, dependent: :destroy
  has_one :internship,
          -> { where(kind: "internship") },
          class_name: "PostGraduateTraining",
          dependent: :destroy
  has_one :loan_repayment_detail, dependent: :destroy
  has_one :medical_degree, dependent: :destroy
  has_one :military_service_detail, dependent: :destroy
  has_one :national_health_service_corps_scholarship, dependent: :destroy
  has_one :other_degree,
          -> { where(kind: "other") },
          class_name: "Degree",
          dependent: :destroy
  has_one :passport, dependent: :destroy
  has_one :ppd_tuberculosis_testing, dependent: :destroy
  has_one :primary_certification,
          -> { where(specialty_rank: "primary") },
          class_name: "BoardCertification",
          dependent: :destroy
  has_one :professional_liability_insurance_carrier, dependent: :destroy
  has_one :professional_liability_judgments_questionnaire, dependent: :destroy
  has_one :residency,
          -> { where(kind: "residency") },
          class_name: "PostGraduateTraining",
          dependent: :destroy
  has_one :secondary_certification,
          lambda {
            where(specialty_rank: "secondary")
          },
          class_name: "BoardCertification",
          dependent: :destroy
  has_one :undergraduate_degree,
          -> { where(kind: "undergraduate") },
          class_name: "Degree",
          dependent: :destroy
  has_one :united_states_public_health_service, dependent: :destroy
  has_one :usmle_score, dependent: :destroy

  has_many :academic_appointments, dependent: :destroy
  has_many :administrative_leadership_positions, dependent: :destroy
  has_many :certifications, dependent: :destroy
  has_many :cme_credit_hours, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :form_completions, dependent: :destroy
  has_many :healthcare_facility_affiliations, dependent: :destroy
  has_many :hospital_affiliations, dependent: :destroy
  has_many :insurance_policies, dependent: :destroy
  has_many :malpractice_claims, dependent: :destroy
  has_many :medical_group_employers, dependent: :destroy
  has_many :peer_references, dependent: :destroy
  has_many :prior_names, dependent: :destroy
  has_many :professional_licenses, dependent: :destroy
  has_many :sharing_events, dependent: :destroy
  has_many :spoken_languages, dependent: :destroy

  has_many :other_professional_licenses,
           -> { where(kind: :other) },
           class_name: "ProfessionalLicense",
           dependent: :destroy
  has_many :state_medical_licenses,
           -> { where(kind: :medical) },
           class_name: "ProfessionalLicense",
           dependent: :destroy
  has_many :xray_fluoroscopy_licenses,
           -> { where(kind: :xray_fluoroscopy) },
           class_name: "ProfessionalLicense",
           dependent: :destroy

  accepts_nested_attributes_for :certifications
  accepts_nested_attributes_for :cme_credit_hours
  accepts_nested_attributes_for :healthcare_facility_affiliations
  accepts_nested_attributes_for :academic_appointments
  accepts_nested_attributes_for :hospital_affiliations
  accepts_nested_attributes_for :medical_group_employers
  accepts_nested_attributes_for :insurance_policies
  accepts_nested_attributes_for :malpractice_claims
  accepts_nested_attributes_for :spoken_languages
  accepts_nested_attributes_for :prior_names
  accepts_nested_attributes_for :professional_licenses
  accepts_nested_attributes_for :administrative_leadership_positions

  enum legal_gender: { not_known: 0, male: 1, female: 2, not_applicable: 9 }

  validates :user, presence: true
  validates :first_name, :last_name, presence: true
  validates :legal_gender, presence: true

  validates :mailing_address_same_as_home, inclusion: [true, false]

  # Birth and citizenship related validations
  validates :country_of_citizenship,
            inclusion: CS.countries.values,
            if: -> { country_of_citizenship.present? }

  validates :us_permanent_resident,
            inclusion: [true, false]

  def full_name
    [first_name, last_name].join(" ")
  end

  def clear_mailing_address
    assign_attributes(
      mailing_address_line_1: nil,
      mailing_address_line_2: nil,
      mailing_address_line_3: nil,
      mailing_address_city: nil,
      mailing_address_state: nil,
      mailing_address_zip: nil,
      mailing_address_country: nil
    )
  end
end
