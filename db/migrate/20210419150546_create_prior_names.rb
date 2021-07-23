class CreatePriorNames < ActiveRecord::Migration[6.1]
  def change
    create_table :prior_names do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.string :name, null: false
      t.string :comment
      t.timestamp :started_at, null: false
      t.timestamp :ended_at, null: false

      t.timestamps
    end
  end

  remove_column :people, :known_by_other_names, :boolean, null: false, default: false
  remove_column :people, :prior_first_names, :string
  remove_column :people, :prior_last_names, :string
  remove_column :people, :name_change_explanation, :string
end
