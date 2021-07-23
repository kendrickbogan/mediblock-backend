class CreateCertifications < ActiveRecord::Migration[6.1]
  def change
    create_table :certifications do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.integer :kind, null: false, default: 0
      t.string :other_name
      t.timestamp :issued_at, null: false
      t.timestamp :renewal_recommended_at

      t.timestamps
    end
  end
end
