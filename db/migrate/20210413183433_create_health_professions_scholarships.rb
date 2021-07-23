class CreateHealthProfessionsScholarships < ActiveRecord::Migration[6.1]
  def change
    create_table :health_professions_scholarships do |t|
      t.references :person, index: true, foreign_key: true, null: false

      t.string :military_branch_scholarship_sponsor, null: false

      t.timestamp :started_at, null: false
      t.timestamp :ended_at, null: false
      t.timestamps
    end
  end
end
