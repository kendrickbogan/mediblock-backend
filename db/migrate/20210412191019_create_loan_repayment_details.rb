class CreateLoanRepaymentDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :loan_repayment_details do |t|
      t.references :person, index: true, foreign_key: true, null: false

      t.string :repayment_program_name
      t.string :name_of_institution
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :zip

      t.integer :years_worked_for_repayment

      t.timestamp :started_at
      t.timestamp :ended_at
      t.timestamps
    end
  end
end
