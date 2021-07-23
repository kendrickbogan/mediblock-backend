class CreateAcademicAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :academic_appointments do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.string :position, null: false
      t.string :institution_name, null: false
      t.string :address_line_1, null: false
      t.string :address_line_2
      t.string :city, null: false
      t.string :state
      t.string :country, null: false
      t.string :zip, null: false
      t.string :phone_number
      t.string :fax_number
      t.string :institution_url
      t.string :department_head_first_name
      t.string :department_head_last_name

      t.timestamp :started_at, null: false
      t.timestamp :ended_at

      t.timestamps
    end
  end
end
