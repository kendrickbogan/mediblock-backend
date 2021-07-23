class AddIdNumbersToPeople < ActiveRecord::Migration[6.1]
  def change
    change_table :people do |t|
      t.string :orcid_id
      t.string :researcher_id
      t.string :scopus_author_id
    end
  end
end
