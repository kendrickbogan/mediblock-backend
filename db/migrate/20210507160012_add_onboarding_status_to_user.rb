class AddOnboardingStatusToUser < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.integer :onboarding_status, default: 0, null: false
    end
  end
end
