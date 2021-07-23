class AddDocumentKindToDocuments < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :kind, :integer, null: false, default: 0
  end
end
