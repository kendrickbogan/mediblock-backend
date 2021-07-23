class CreateUndergraduateDegrees < ActiveRecord::Migration[6.1]
  def change
    create_table :undergraduate_degrees do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.string :institution_name, null: false
      t.string :degree, null: false
      t.string :major, null: false
      t.string :minor, null: false
      t.timestamp :date_of_graduation, null: false
      t.timestamp :started_at, null: false
      t.timestamp :ended_at, null: false
      t.string :registrar_phone_number, null: false
      t.string :registrar_url, null: false
      t.string :institution_address_line_1, null: false
      t.string :institution_address_line_2
      t.string :institution_address_line_3
      t.string :institution_address_city, null: false
      t.string :institution_address_state, null: false
      t.string :institution_address_zip, null: false
      t.string :institution_address_country, null: false

      t.timestamps
    end
  end
end
