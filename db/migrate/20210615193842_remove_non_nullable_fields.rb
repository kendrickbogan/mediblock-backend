class RemoveNonNullableFields < ActiveRecord::Migration[6.1]
  def change
    change_column_null :administrative_leadership_positions, :title, true

    change_column_null :board_certifications, :specialty, true

    change_column_null :cme_credit_hours, :activity_name, true
    change_column_null :cme_credit_hours, :method_of_education, true

    change_column_null :comlex_usa_scores, :nbome_id_number, true

    change_column_null :covid_vaccinations, :facility_name, true

    change_column_null :dea_licenses, :registration_number, true
    change_column_null :dea_licenses, :status, true

    change_column_null :degrees, :degree, true
    change_column_null :degrees, :institution_address_city, true
    change_column_null :degrees, :institution_address_country, true
    change_column_null :degrees, :institution_address_line_1, true
    change_column_null :degrees, :institution_address_state, true
    change_column_null :degrees, :institution_address_zip, true
    change_column_null :degrees, :institution_name, true
    change_column_null :degrees, :registrar_phone_number, true
    change_column_null :degrees, :registrar_url, true

    change_column_null :drivers_licenses, :number, true
    change_column_null :drivers_licenses, :issuing_state, true

    change_column_null :health_professions_scholarships, :military_branch_scholarship_sponsor, true

    change_column_null :medical_degrees, :institution_address_city, true
    change_column_null :medical_degrees, :institution_address_country, true
    change_column_null :medical_degrees, :institution_address_line_1, true
    change_column_null :medical_degrees, :institution_address_state, true
    change_column_null :medical_degrees, :institution_address_zip, true
    change_column_null :medical_degrees, :institution_name, true
    change_column_null :medical_degrees, :registrar_phone_number, true
    change_column_null :medical_degrees, :registrar_url, true

    change_column_null :medical_group_employers, :name, true

    change_column_null :military_service_details, :branch_of_service, true

    change_column_null :passports, :country_of_issue, true
    change_column_null :passports, :number, true

    change_column_null :people, :npi_number, true
    change_column_null :people, :visa_expires_at, true
    change_column_null :people, :visa_number, true
    change_column_null :people, :visa_status, true
    change_column_null :people, :visa_type, true

    change_column_null :post_graduate_trainings, :institution_name, true

    change_column_null :professional_licenses, :issuing_authority, true
    change_column_null :professional_licenses, :issuing_state, true
    change_column_null :professional_licenses, :number, true
    change_column_null :professional_licenses, :status, true

    change_column_null :usmle_scores, :usmle_id_number, true
  end
end
