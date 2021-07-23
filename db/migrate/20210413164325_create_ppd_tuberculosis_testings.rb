class CreatePPDTuberculosisTestings < ActiveRecord::Migration[6.1]
  def change
    create_table :ppd_tuberculosis_testings do |t|
      t.references :person, index: true, foreign_key: true, null: false

      t.boolean :received_bcg_vaccine, default: false, null: false

      t.string :testing_site_name
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :zip

      t.integer :ppd_induration
      t.integer :ppd_interpretation

      t.timestamp :test_date
      t.timestamps
    end
  end
end
