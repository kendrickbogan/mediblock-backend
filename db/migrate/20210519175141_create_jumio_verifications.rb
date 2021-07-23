class CreateJumioVerifications < ActiveRecord::Migration[6.1]
  def change
    create_table :jumio_identity_verifications, id: false do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.string :scan_reference, index: true, null: false
      t.integer :verification_status, null: false, default: 0

      t.timestamps
    end
  end
end
