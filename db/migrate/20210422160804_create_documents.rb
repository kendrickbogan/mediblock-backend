class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.references :person, index: true, foreign_key: true, null: false

      t.string :name, null: false
      t.integer :category, null: false, index: true, default: 0
      t.timestamp :expires_at, null: true

      t.timestamps
    end
  end
end
