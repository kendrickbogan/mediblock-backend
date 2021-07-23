class UpdatePPDTuberculosisTestings < ActiveRecord::Migration[6.1]
  def change
    change_table :ppd_tuberculosis_testings do |t|
      t.boolean :tested_in_the_last_year, default: false, null: false
      t.boolean :had_positive_tb_skin_test, default: false, null: false
      t.boolean :tested_more_than_5_years_ago, default: false, null: false
      t.timestamp :tested_positive_at
      t.string :year_tested_positive
      t.integer :test_reaction_size

      t.boolean :had_tb_disease_diagnosis, default: false, null: false
      t.boolean :has_taken_inh_or_rifampin, default: false, null: false
      t.boolean :treatment_completed_more_than_5_years_ago, default: false, null: false
      t.timestamp :treatment_completed_at
      t.string :year_treatment_completed
      t.timestamp :last_chest_xray_at
    end
  end
end
