class CreatePassports < ActiveRecord::Migration[6.1]
  def change
    create_table :passports do |t|
      t.string :country_of_issue, null: false
      t.string :number, null: false
      t.timestamp :expiration_date, null: false
      t.references :person, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
