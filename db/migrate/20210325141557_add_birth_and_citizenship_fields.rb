class AddBirthAndCitizenshipFields < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :date_of_birth, :timestamp, null: false
    add_column :people, :place_of_birth_city, :string, null: false
    add_column :people, :place_of_birth_state, :string
    add_column :people, :place_of_birth_country, :string, null: false
    add_column :people, :country_of_citizenship, :string, null: false
    add_column :people, :us_permanent_resident, :boolean, null: false, default: false
    add_column :people, :visa_type, :string
    add_column :people, :visa_number, :string
    add_column :people, :visa_status, :string
    add_column :people, :visa_expires_at, :timestamp
  end
end
