class CreateSpokenLanguages < ActiveRecord::Migration[6.1]
  def change
    create_table :spoken_languages do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.string :language, null: false
      t.integer :reading_proficiency, null: false, default: 0
      t.integer :speaking_proficiency, null: false, default: 0
      t.integer :writing_proficiency, null: false, default: 0

      t.timestamps
    end
  end
end
