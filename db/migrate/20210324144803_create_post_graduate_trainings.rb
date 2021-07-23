class CreatePostGraduateTrainings < ActiveRecord::Migration[6.1]
  def change
    create_table :post_graduate_trainings do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.string :institution_name, null: false
      t.integer :kind, null: false, default: 0
      t.string :director_during_first_name
      t.string :director_during_last_name
      t.string :director_contact_number
      t.string :director_contact_email
      t.string :current_program_director_first_name
      t.string :current_program_director_last_name
      t.string :program_director_address_line_1
      t.string :program_director_address_line_2
      t.string :program_director_address_line_3
      t.string :program_director_address_city
      t.string :program_director_address_state
      t.string :program_director_address_country
      t.string :program_director_address_zip
      t.string :program_admin_name
      t.string :program_admin_phone
      t.string :program_admin_email
      t.string :gme_office_email
      t.string :gme_office_phone
      t.string :gme_office_url
      t.string :fellowship_kind
      t.string :internship_kind
      t.string :residency_kind
      t.boolean :acgme_accredited, null: false, default: false
      t.boolean :successfully_completed_program, null: false, default: false
      t.timestamp :attendance_start_date, null: false
      t.timestamp :attendance_end_date

      t.timestamps
    end
  end
end
