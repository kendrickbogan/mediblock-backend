class AddExpirationWarningTimeToUser < ActiveRecord::Migration[6.1]
  def change
    create_enum :expiration_warning_time_units, %w[weeks months]

    add_column :users, :expiration_warning_time_units, :expiration_warning_time_units, null: false, default: "months"
    add_column :users, :expiration_warning_time, :integer, null: false, default: 3
  end
end
