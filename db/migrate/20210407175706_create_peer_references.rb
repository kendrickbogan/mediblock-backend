class CreatePeerReferences < ActiveRecord::Migration[6.1]
  def change
    create_table :peer_references do |t|
      t.references :person, index: true, foreign_key: true, null: false

      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :degree
      t.string :specialty
      t.string :relationship
      t.string :phone_number
      t.string :email_address
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.boolean :has_worked_with_in_the_past_two_years
      t.integer :years_known
      t.integer :position, null: false, default: 0

      t.timestamps
    end
  end
end
