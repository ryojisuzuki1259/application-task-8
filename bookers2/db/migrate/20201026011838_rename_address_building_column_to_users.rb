class RenameAddressBuildingColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :address_building, :building
  end
end
