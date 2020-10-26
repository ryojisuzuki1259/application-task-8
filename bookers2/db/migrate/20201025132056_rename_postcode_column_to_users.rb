class RenamePostcodeColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :postcode, :postal_code
  end
end
