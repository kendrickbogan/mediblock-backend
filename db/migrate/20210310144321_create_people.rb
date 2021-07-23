class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :middle_name
      t.string :maiden_name
      t.string :suffix

      t.boolean :known_by_other_names, default: false, null: false
      t.string :prior_first_names
      t.string :prior_last_names
      t.string :name_change_explanation

      t.integer :legal_gender, default: 0, null: false

      t.string :social_security_number
      t.string :npi_number
      t.string :personal_medicare_number
      t.string :personal_medicaid_number
      t.string :upin_number

      t.string :cell_phone_number
      t.string :emergency_contact_number

      t.timestamps
    end
  end
end
