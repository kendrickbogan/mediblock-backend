class AddProviderProfessionType < ActiveRecord::Migration[6.1]
  def change
    change_table :people do |t|
      t.string :provider_profession_type
    end
  end
end
