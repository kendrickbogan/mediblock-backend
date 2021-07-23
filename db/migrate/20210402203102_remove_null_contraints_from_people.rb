class RemoveNullContraintsFromPeople < ActiveRecord::Migration[6.1]
  def change
    change_column_null :people, :home_address_line_1, true
    change_column_null :people, :home_address_city, true
    change_column_null :people, :home_address_state, true
    change_column_null :people, :home_address_zip, true
    change_column_null :people, :home_address_country, true
    change_column_null :people, :date_of_birth, true
    change_column_null :people, :place_of_birth_city, true
    change_column_null :people, :place_of_birth_country, true
    change_column_null :people, :country_of_citizenship, true
  end
end
