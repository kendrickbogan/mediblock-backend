class CreateEmploymentGaps < ActiveRecord::Migration[6.1]
  def change
    create_table :employment_gaps do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.string :text

      t.timestamps
    end
  end
end
