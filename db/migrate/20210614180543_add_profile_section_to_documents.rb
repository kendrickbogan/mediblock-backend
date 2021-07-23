class AddProfileSectionToDocuments < ActiveRecord::Migration[6.1]
  def change
    add_column :documents,
               :profile_section,
               :integer,
               default: Document.profile_sections["personal"],
               null: false
  end
end
