class CreateBoardCertifications < ActiveRecord::Migration[6.1]
  def change
    create_table :board_certifications do |t|
      t.references :person, index: true, foreign_key: true
      t.string :specialty, null: false
      t.integer :specialty_rank, null: false
      t.boolean :board_certified, null: false, default: true
      t.string :certifying_board_name, null: true
      t.timestamp :initial_certification_date, null: true
      t.timestamp :recertification_date, null: true
      t.timestamp :expiration_date, null: true

      t.timestamps
    end

    create_table :board_certification_questionnaires do |t|
      t.references :board_certification,
                   index: { name: :index_questionnaires_on_board_certification_id },
                   foreign_key: true

      t.boolean :has_taken_certification_exam, null: false, default: false
      t.string :has_taken_certification_exam_board_name, null: true

      t.boolean :taken_part_one_part_two_eligible, null: false, default: false
      t.string :taken_part_one_part_two_eligible_board_name, null: true

      t.boolean :planning_to_take_exam, null: false, default: false
      t.timestamp :expected_exam_date, null: true

      t.string :comments, null: true
    end
  end
end
