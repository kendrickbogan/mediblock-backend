class CreateCOMLEXUSAScores < ActiveRecord::Migration[6.1]
  def change
    create_table :comlex_usa_scores do |t|
      t.references :person, index: true, foreign_key: true, null: true
      t.string :nbome_id_number, null: false

      t.boolean :level_1_passed
      t.integer :level_1_score
      t.datetime :level_1_exam_date

      t.boolean :level_2_ce_passed
      t.integer :level_2_ce_score
      t.datetime :level_2_ce_exam_date

      t.boolean :level_2_pe_passed
      t.integer :level_2_pe_score
      t.datetime :level_2_pe_exam_date

      t.boolean :level_3_passed
      t.integer :level_3_score
      t.datetime :level_3_exam_date

      t.timestamps
    end
  end
end
