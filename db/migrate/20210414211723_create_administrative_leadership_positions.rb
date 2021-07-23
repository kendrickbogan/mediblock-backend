class CreateAdministrativeLeadershipPositions < ActiveRecord::Migration[6.1]
  def change
    create_table :administrative_leadership_positions do |t|
      t.references :person, index: true, foreign_key: true, null: false

      t.string :title, null: false
      t.timestamp :started_at
      t.timestamp :ended_at

      t.timestamps
    end
  end
end
