class RenameAddressCityColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :address_city, :city
  end
end
