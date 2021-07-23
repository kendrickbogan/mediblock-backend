class AddCompletionStatusToFormRelatedModels < ActiveRecord::Migration[6.1]
  def change
    create_enum :completion_status, %w[not_started in_progress completed not_applicable]

    create_table :form_completions do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.enum :status, enum_name: :completion_status, null: false, default: "not_started"
      t.integer :profile_section, null: false
      t.integer :category, null: false
    end

    add_index :form_completions, [:person_id, :profile_section]
  end
end
