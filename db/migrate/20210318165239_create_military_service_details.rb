class CreateMilitaryServiceDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :military_service_details do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.string :branch_of_service, null: false
      t.datetime :started_at, null: false
      t.datetime :ended_at
      t.boolean :has_dd214, null: false, default: false

      t.timestamps
    end
  end
end
