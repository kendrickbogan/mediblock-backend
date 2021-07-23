class AddAddressFieldsToPerson < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :home_address_line_1, :string, null: false
    add_column :people, :home_address_line_2, :string
    add_column :people, :home_address_line_3, :string
    add_column :people, :home_address_city, :string, null: false
    add_column :people, :home_address_state, :string, null: false
    add_column :people, :home_address_country, :string, null: false
    add_column :people, :home_address_zip, :string, null: false

    add_column :people, :mailing_address_same_as_home, :boolean, null: false, default: true
    add_column :people, :mailing_address_line_1, :string
    add_column :people, :mailing_address_line_2, :string
    add_column :people, :mailing_address_line_3, :string
    add_column :people, :mailing_address_city, :string
    add_column :people, :mailing_address_state, :string
    add_column :people, :mailing_address_country, :string
    add_column :people, :mailing_address_zip, :string
  end
end
