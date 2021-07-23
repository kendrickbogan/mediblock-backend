class AddOtherDocumentKindToDocuments < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :other_kind, :string, null: true
  end
end
