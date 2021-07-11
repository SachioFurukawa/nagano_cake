class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :family_name, :string
    add_column :users, :kana_first_name, :string
    add_column :users, :kana_family_name, :string
    add_column :users, :postal_code, :string
    add_column :users, :address, :string
    add_column :users, :phone_number, :string
    add_column :users, :status, :boolean
  end
end
