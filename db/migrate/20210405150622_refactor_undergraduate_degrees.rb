class RefactorUndergraduateDegrees < ActiveRecord::Migration[6.1]
  def change
    rename_table :undergraduate_degrees, :degrees
    add_column :degrees, :kind, :integer, null: false, default: 0
  end
end
