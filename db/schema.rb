# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_29_203052) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_enum :completion_status, [
    "not_started",
    "in_progress",
    "completed",
    "not_applicable",
  ], force: :cascade

  create_enum :expiration_warning_time_units, [
    "weeks",
    "months",
  ], force: :cascade

  create_table "academic_appointments", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "position", null: false
    t.string "institution_name", null: false
    t.string "address_line_1", null: false
    t.string "address_line_2"
    t.string "city", null: false
    t.string "state"
    t.string "country", null: false
    t.string "zip", null: false
    t.string "phone_number"
    t.string "fax_number"
    t.string "institution_url"
    t.string "department_head_first_name"
    t.string "department_head_last_name"
    t.datetime "started_at", null: false
    t.datetime "ended_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_academic_appointments_on_person_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "administrative_leadership_positions", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "title"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_administrative_leadership_positions_on_person_id"
  end

  create_table "board_certification_questionnaires", force: :cascade do |t|
    t.bigint "board_certification_id"
    t.boolean "has_taken_certification_exam", default: false, null: false
    t.string "has_taken_certification_exam_board_name"
    t.boolean "taken_part_one_part_two_eligible", default: false, null: false
    t.string "taken_part_one_part_two_eligible_board_name"
    t.boolean "planning_to_take_exam", default: false, null: false
    t.datetime "expected_exam_date"
    t.string "comments"
    t.index ["board_certification_id"], name: "index_questionnaires_on_board_certification_id"
  end

  create_table "board_certifications", force: :cascade do |t|
    t.bigint "person_id"
    t.string "specialty"
    t.integer "specialty_rank", null: false
    t.boolean "board_certified", default: true, null: false
    t.string "certifying_board_name"
    t.datetime "initial_certification_date"
    t.datetime "recertification_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_board_certifications_on_person_id"
  end

  create_table "certifications", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.integer "kind", default: 0, null: false
    t.string "other_name"
    t.datetime "issued_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_certifications_on_person_id"
  end

  create_table "cme_credit_hours", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "activity_name"
    t.datetime "activity_date", null: false
    t.string "sponsor_name"
    t.string "method_of_education"
    t.decimal "hours_earned", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_cme_credit_hours_on_person_id"
  end

  create_table "comlex_usa_scores", force: :cascade do |t|
    t.bigint "person_id"
    t.string "nbome_id_number"
    t.boolean "level_1_passed"
    t.integer "level_1_score"
    t.datetime "level_1_exam_date"
    t.boolean "level_2_ce_passed"
    t.integer "level_2_ce_score"
    t.datetime "level_2_ce_exam_date"
    t.boolean "level_2_pe_passed"
    t.integer "level_2_pe_score"
    t.datetime "level_2_pe_exam_date"
    t.boolean "level_3_passed"
    t.integer "level_3_score"
    t.datetime "level_3_exam_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_comlex_usa_scores_on_person_id"
  end

  create_table "covid_vaccinations", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.datetime "vaccination_date_1", null: false
    t.datetime "vaccination_date_2", null: false
    t.string "facility_name"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_covid_vaccinations_on_person_id"
  end

  create_table "dea_licenses", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "registration_number"
    t.string "status"
    t.boolean "unrestricted", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_dea_licenses_on_person_id"
  end

  create_table "degrees", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "institution_name"
    t.string "degree"
    t.string "major", null: false
    t.string "minor", null: false
    t.datetime "date_of_graduation", null: false
    t.datetime "started_at", null: false
    t.datetime "ended_at", null: false
    t.string "registrar_phone_number"
    t.string "registrar_url"
    t.string "institution_address_line_1"
    t.string "institution_address_line_2"
    t.string "institution_address_line_3"
    t.string "institution_address_city"
    t.string "institution_address_state"
    t.string "institution_address_zip"
    t.string "institution_address_country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "kind", default: 0, null: false
    t.index ["person_id"], name: "index_degrees_on_person_id"
  end

  create_table "demographic_details", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "race", null: false
    t.integer "ethnicity", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_demographic_details_on_person_id"
  end

  create_table "documents", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "name", null: false
    t.integer "category", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "kind", default: 0, null: false
    t.string "other_kind"
    t.integer "profile_section", default: 40, null: false
    t.datetime "deleted_at"
    t.index ["category"], name: "index_documents_on_category"
    t.index ["person_id"], name: "index_documents_on_person_id"
  end

  create_table "documents_sharing_events", force: :cascade do |t|
    t.bigint "document_id", null: false
    t.bigint "sharing_event_id", null: false
    t.index ["document_id"], name: "index_documents_sharing_events_on_document_id"
    t.index ["sharing_event_id"], name: "index_documents_sharing_events_on_sharing_event_id"
  end

  create_table "drivers_licenses", force: :cascade do |t|
    t.string "issuing_state"
    t.bigint "person_id", null: false
    t.string "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_drivers_licenses_on_person_id"
  end

  create_table "employment_gaps", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_employment_gaps_on_person_id"
  end

  create_table "expirations", force: :cascade do |t|
    t.string "expirable_type", null: false
    t.bigint "expirable_id", null: false
    t.bigint "person_id", null: false
    t.integer "category", default: 0, null: false
    t.integer "profile_section", default: 0
    t.datetime "expires_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["expirable_type", "expirable_id"], name: "index_expirations_on_expirable"
    t.index ["person_id"], name: "index_expirations_on_person_id"
  end

  create_table "form_completions", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.enum "status", default: "not_started", null: false, enum_name: "completion_status"
    t.integer "profile_section", null: false
    t.integer "category", null: false
    t.index ["person_id", "profile_section"], name: "index_form_completions_on_person_id_and_profile_section"
    t.index ["person_id"], name: "index_form_completions_on_person_id"
  end

  create_table "health_professions_scholarships", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "military_branch_scholarship_sponsor"
    t.datetime "started_at", null: false
    t.datetime "ended_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_health_professions_scholarships_on_person_id"
  end

  create_table "healthcare_facility_affiliations", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "facility_name", null: false
    t.string "facility_type"
    t.string "department_or_division_name"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zip_code"
    t.integer "membership_status", default: 0, null: false
    t.string "medical_staff_office_phone_number"
    t.string "medical_staff_office_fax_number"
    t.boolean "privilege_limitations", default: false, null: false
    t.string "comments"
    t.datetime "started_at", null: false
    t.datetime "ended_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "facility_legal_business_name"
    t.index ["person_id"], name: "index_healthcare_facility_affiliations_on_person_id"
  end

  create_table "hospital_affiliations", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "hospital_name"
    t.string "department_name"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zip_code"
    t.integer "membership_status", default: 0, null: false
    t.string "staff_office_phone_number"
    t.string "staff_office_fax_number"
    t.boolean "privilege_limitations", default: false, null: false
    t.string "comments"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "hospital_legal_business_name"
    t.index ["person_id"], name: "index_hospital_affiliations_on_person_id"
  end

  create_table "influenza_vaccinations", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.boolean "has_been_vaccinated", default: false, null: false
    t.string "flu_season"
    t.string "facility_name"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "no_vaccination_comment"
    t.datetime "vaccinated_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_influenza_vaccinations_on_person_id"
  end

  create_table "insurance_policies", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "entity_name"
    t.boolean "self_insured", default: false, null: false
    t.boolean "covered_by_ftca", default: false, null: false
    t.boolean "tail_coverage", default: false, null: false
    t.string "policy_number", default: "f", null: false
    t.money "per_claim_amount", scale: 2, default: "0.0", null: false
    t.money "aggregate_amount", scale: 2, default: "0.0", null: false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.integer "claims_coverage_type", default: 0, null: false
    t.integer "coverage_type", default: 0, null: false
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "email"
    t.string "phone_number"
    t.string "fax_number"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_insurance_policies_on_person_id"
  end

  create_table "jumio_identity_verifications", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "scan_reference", null: false
    t.integer "verification_status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["scan_reference"], name: "index_jumio_identity_verifications_on_scan_reference"
    t.index ["user_id"], name: "index_jumio_identity_verifications_on_user_id"
  end

  create_table "loan_repayment_details", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "repayment_program_name"
    t.string "name_of_institution"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.integer "years_worked_for_repayment"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_loan_repayment_details_on_person_id"
  end

  create_table "malpractice_claims", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.datetime "alleged_incident_date", null: false
    t.datetime "claim_filed_at", null: false
    t.string "claim_status"
    t.string "insurance_carrier_involved"
    t.string "policy_number_covered_by"
    t.money "settlement_amount", scale: 2
    t.money "amount_paid", scale: 2
    t.integer "method_of_resolution", default: 0, null: false
    t.string "resolution_comment"
    t.string "description_of_allegations"
    t.integer "defendant_type", default: 0, null: false
    t.integer "number_of_co_defendants", default: 0, null: false
    t.string "involvement_description"
    t.string "description_of_alleged_injury"
    t.boolean "included_in_npdb", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_malpractice_claims_on_person_id"
  end

  create_table "medical_degrees", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "institution_name"
    t.integer "kind", default: 0, null: false
    t.datetime "date_of_graduation", null: false
    t.datetime "started_at", null: false
    t.datetime "ended_at", null: false
    t.string "registrar_phone_number"
    t.string "registrar_url"
    t.boolean "foreign_medical_school", default: false, null: false
    t.boolean "ecfmg_certified", default: false, null: false
    t.datetime "ecfmg_certified_at"
    t.string "institution_address_line_1"
    t.string "institution_address_line_2"
    t.string "institution_address_line_3"
    t.string "institution_address_city"
    t.string "institution_address_state"
    t.string "institution_address_zip"
    t.string "institution_address_country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_medical_degrees_on_person_id"
  end

  create_table "medical_group_employers", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "name"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zip"
    t.string "phone_number"
    t.datetime "started_at", null: false
    t.datetime "ended_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "legal_business_name"
    t.index ["person_id"], name: "index_medical_group_employers_on_person_id"
  end

  create_table "military_service_details", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "branch_of_service"
    t.datetime "started_at", null: false
    t.datetime "ended_at"
    t.boolean "has_dd214", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_military_service_details_on_person_id"
  end

  create_table "national_health_service_corps_scholarships", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.datetime "started_at", null: false
    t.datetime "ended_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_national_health_service_corps_scholarships_on_person_id"
  end

  create_table "passports", force: :cascade do |t|
    t.string "country_of_issue"
    t.string "number"
    t.bigint "person_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_passports_on_person_id"
  end

  create_table "peer_references", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.string "degree"
    t.string "specialty"
    t.string "relationship"
    t.string "phone_number"
    t.string "email_address"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zip"
    t.boolean "has_worked_with_in_the_past_two_years"
    t.integer "years_known"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_peer_references_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.bigint "user_id"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "middle_name"
    t.string "maiden_name"
    t.string "suffix"
    t.integer "legal_gender", default: 0, null: false
    t.string "social_security_number"
    t.string "npi_number"
    t.string "personal_medicare_number"
    t.string "personal_medicaid_number"
    t.string "upin_number"
    t.string "cell_phone_number"
    t.string "emergency_contact_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "home_address_line_1"
    t.string "home_address_line_2"
    t.string "home_address_line_3"
    t.string "home_address_city"
    t.string "home_address_state"
    t.string "home_address_country"
    t.string "home_address_zip"
    t.boolean "mailing_address_same_as_home", default: true, null: false
    t.string "mailing_address_line_1"
    t.string "mailing_address_line_2"
    t.string "mailing_address_line_3"
    t.string "mailing_address_city"
    t.string "mailing_address_state"
    t.string "mailing_address_country"
    t.string "mailing_address_zip"
    t.datetime "date_of_birth"
    t.string "place_of_birth_city"
    t.string "place_of_birth_state"
    t.string "place_of_birth_country"
    t.string "country_of_citizenship"
    t.boolean "us_permanent_resident", default: false, null: false
    t.string "visa_type"
    t.string "visa_number"
    t.string "visa_status"
    t.datetime "visa_expires_at"
    t.string "orcid_id"
    t.string "researcher_id"
    t.string "scopus_author_id"
    t.string "provider_profession_type"
    t.index ["user_id"], name: "index_people_on_user_id"
  end

  create_table "post_graduate_trainings", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "institution_name"
    t.integer "kind", default: 0, null: false
    t.string "director_during_first_name"
    t.string "director_during_last_name"
    t.string "director_contact_number"
    t.string "director_contact_email"
    t.string "current_program_director_first_name"
    t.string "current_program_director_last_name"
    t.string "program_director_address_line_1"
    t.string "program_director_address_line_2"
    t.string "program_director_address_line_3"
    t.string "program_director_address_city"
    t.string "program_director_address_state"
    t.string "program_director_address_country"
    t.string "program_director_address_zip"
    t.string "program_admin_name"
    t.string "program_admin_phone"
    t.string "program_admin_email"
    t.string "gme_office_email"
    t.string "gme_office_phone"
    t.string "gme_office_url"
    t.string "fellowship_kind"
    t.string "internship_kind"
    t.string "residency_kind"
    t.boolean "acgme_accredited", default: false, null: false
    t.boolean "successfully_completed_program", default: false, null: false
    t.datetime "attendance_start_date", null: false
    t.datetime "attendance_end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_post_graduate_trainings_on_person_id"
  end

  create_table "ppd_tuberculosis_testings", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.boolean "received_bcg_vaccine", default: false, null: false
    t.string "testing_site_name"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.integer "ppd_induration"
    t.integer "ppd_interpretation"
    t.datetime "test_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "tested_in_the_last_year", default: false, null: false
    t.boolean "had_positive_tb_skin_test", default: false, null: false
    t.boolean "tested_more_than_5_years_ago", default: false, null: false
    t.datetime "tested_positive_at"
    t.string "year_tested_positive"
    t.integer "test_reaction_size"
    t.boolean "had_tb_disease_diagnosis", default: false, null: false
    t.boolean "has_taken_inh_or_rifampin", default: false, null: false
    t.boolean "treatment_completed_more_than_5_years_ago", default: false, null: false
    t.datetime "treatment_completed_at"
    t.string "year_treatment_completed"
    t.datetime "last_chest_xray_at"
    t.index ["person_id"], name: "index_ppd_tuberculosis_testings_on_person_id"
  end

  create_table "prior_names", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "name", null: false
    t.string "comment"
    t.datetime "started_at", null: false
    t.datetime "ended_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_prior_names_on_person_id"
  end

  create_table "professional_liability_insurance_carriers", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "malpractice_type"
    t.string "organization_name", null: false
    t.string "organization_address_line_1"
    t.string "organization_address_line_2"
    t.string "organization_city"
    t.string "organization_state"
    t.string "organization_zip"
    t.string "organization_phone_number"
    t.string "organization_email_address"
    t.string "organization_fax_number"
    t.string "contact_person_first_name"
    t.string "contact_person_last_name"
    t.string "contact_person_role"
    t.string "contact_person_phone_number"
    t.string "contact_person_email_address"
    t.string "contact_person_fax_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_professional_liability_insurance_carriers_on_person_id"
  end

  create_table "professional_liability_judgments_questionnaires", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.boolean "judgments_entered", default: false, null: false
    t.boolean "liability_claim_settlements_paid", default: false, null: false
    t.boolean "pending_liability_actions", default: false, null: false
    t.boolean "any_legal_action_due_to_clinical_actions", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_liability_questionnaire_on_person_id"
  end

  create_table "professional_licenses", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "issuing_state"
    t.string "issuing_authority"
    t.string "number"
    t.string "status"
    t.boolean "unrestricted_license", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "kind", default: 0, null: false
    t.string "non_medical_license_kind"
    t.string "license_verification_url"
    t.datetime "date_of_issue", null: false
    t.index ["person_id"], name: "index_professional_licenses_on_person_id"
  end

  create_table "sharing_event_codes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", null: false
    t.string "code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "sharing_event_id", null: false
    t.index ["code"], name: "index_sharing_event_codes_on_code"
    t.index ["email"], name: "index_sharing_event_codes_on_email"
    t.index ["sharing_event_id"], name: "index_sharing_event_codes_on_sharing_event_id"
  end

  create_table "sharing_events", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "categories_included", default: [], null: false, array: true
    t.string "recipient_emails", default: [], null: false, array: true
    t.string "sent_from_email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["person_id"], name: "index_sharing_events_on_person_id"
    t.index ["uuid"], name: "index_sharing_events_on_uuid"
  end

  create_table "spoken_languages", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "language", null: false
    t.integer "reading_proficiency", default: 0, null: false
    t.integer "speaking_proficiency", default: 0, null: false
    t.integer "writing_proficiency", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_spoken_languages_on_person_id"
  end

  create_table "united_states_public_health_services", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.datetime "started_at", null: false
    t.datetime "ended_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_united_states_public_health_services_on_person_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.integer "onboarding_status", default: 0, null: false
    t.boolean "admin", default: false
    t.enum "expiration_warning_time_units", default: "months", null: false, enum_name: "expiration_warning_time_units"
    t.integer "expiration_warning_time", default: 3, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  create_table "usmle_scores", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "usmle_id_number"
    t.boolean "step_1_exam_passed"
    t.integer "step_1_exam_score"
    t.datetime "step_1_exam_date"
    t.boolean "step_2_exam_passed"
    t.integer "step_2_exam_score"
    t.datetime "step_2_exam_date"
    t.boolean "step_3_exam_passed"
    t.integer "step_3_exam_score"
    t.datetime "step_3_exam_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_usmle_scores_on_person_id"
  end

  add_foreign_key "academic_appointments", "people"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "administrative_leadership_positions", "people"
  add_foreign_key "board_certification_questionnaires", "board_certifications"
  add_foreign_key "board_certifications", "people"
  add_foreign_key "certifications", "people"
  add_foreign_key "cme_credit_hours", "people"
  add_foreign_key "comlex_usa_scores", "people"
  add_foreign_key "covid_vaccinations", "people"
  add_foreign_key "dea_licenses", "people"
  add_foreign_key "degrees", "people"
  add_foreign_key "demographic_details", "people"
  add_foreign_key "documents", "people"
  add_foreign_key "documents_sharing_events", "documents"
  add_foreign_key "documents_sharing_events", "sharing_events"
  add_foreign_key "drivers_licenses", "people"
  add_foreign_key "employment_gaps", "people"
  add_foreign_key "expirations", "people"
  add_foreign_key "form_completions", "people"
  add_foreign_key "health_professions_scholarships", "people"
  add_foreign_key "healthcare_facility_affiliations", "people"
  add_foreign_key "hospital_affiliations", "people"
  add_foreign_key "influenza_vaccinations", "people"
  add_foreign_key "insurance_policies", "people"
  add_foreign_key "jumio_identity_verifications", "users"
  add_foreign_key "loan_repayment_details", "people"
  add_foreign_key "malpractice_claims", "people"
  add_foreign_key "medical_degrees", "people"
  add_foreign_key "medical_group_employers", "people"
  add_foreign_key "military_service_details", "people"
  add_foreign_key "national_health_service_corps_scholarships", "people"
  add_foreign_key "passports", "people"
  add_foreign_key "peer_references", "people"
  add_foreign_key "people", "users"
  add_foreign_key "post_graduate_trainings", "people"
  add_foreign_key "ppd_tuberculosis_testings", "people"
  add_foreign_key "prior_names", "people"
  add_foreign_key "professional_liability_insurance_carriers", "people"
  add_foreign_key "professional_liability_judgments_questionnaires", "people"
  add_foreign_key "professional_licenses", "people"
  add_foreign_key "sharing_event_codes", "sharing_events"
  add_foreign_key "sharing_events", "people"
  add_foreign_key "spoken_languages", "people"
  add_foreign_key "united_states_public_health_services", "people"
  add_foreign_key "usmle_scores", "people"
end
