class CreateCMECreditHours < ActiveRecord::Migration[6.1]
  def change
    create_table :cme_credit_hours do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.string :activity_name, null: false
      t.timestamp :activity_date, null: false
      t.string :sponsor_name
      t.string :method_of_education, null: false
      t.decimal :hours_earned, null: false

      t.timestamps
    end
  end
end
