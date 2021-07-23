class CreateSharingEventCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :sharing_event_codes, id: :uuid do |t|
      t.references :sharing_event, type: :uuid, index: true, foreign_key: true, null: false
      t.string :email, index: true, null: false
      t.string :code, null: false, index: true

      t.index [:sharing_event_id, :email], unique: true

      t.timestamps
    end
  end
end
