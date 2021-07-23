class CreateSharedDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :sharing_events do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.string :categories_included, array: true, default: [], null: false
      t.string :recipient_emails, array: true, default: [], null: false
      t.string :sent_from_email, null: false

      t.timestamps
    end

    create_table :documents_sharing_events do |t|
      t.references :document, index: true, foreign_key: true, null: false
      t.references :sharing_event, index: true, foreign_key: true, null: false
    end
  end
end
