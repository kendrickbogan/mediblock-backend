class CreateUSMLEScores < ActiveRecord::Migration[6.1]
  def change
    create_table :usmle_scores do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.string :usmle_id_number, null: false

      t.boolean :step_1_exam_passed
      t.integer :step_1_exam_score
      t.datetime :step_1_exam_date

      t.boolean :step_2_exam_passed
      t.integer :step_2_exam_score
      t.datetime :step_2_exam_date

      t.boolean :step_3_exam_passed
      t.integer :step_3_exam_score
      t.datetime :step_3_exam_date

      t.timestamps null: false
    end
  end
end
