class AddDeletedAtToDocuments < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :deleted_at, :timestamp, null: true
  end
end
