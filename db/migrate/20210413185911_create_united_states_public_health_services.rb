class CreateUnitedStatesPublicHealthServices < ActiveRecord::Migration[6.1]
  def change
    create_table :united_states_public_health_services do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.timestamp :started_at, null: false
      t.timestamp :ended_at

      t.timestamps
    end
  end
end
