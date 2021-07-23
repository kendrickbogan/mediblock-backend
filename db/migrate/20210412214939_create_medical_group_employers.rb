class CreateMedicalGroupEmployers < ActiveRecord::Migration[6.1]
  def change
    create_table :medical_group_employers do |t|
      t.references :person, index: true, foreign_key: true, null: false

      t.string :name, null: false
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.string :phone_number

      t.timestamp :started_at, null: false
      t.timestamp :ended_at
      t.timestamps
    end
  end
end
