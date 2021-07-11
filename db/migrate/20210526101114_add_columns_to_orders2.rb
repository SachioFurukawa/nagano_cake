class AddColumnsToOrders2 < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :postal_code, :string
    add_column :orders, :name, :string
    add_column :orders, :postage, :integer
    add_column :orders, :total_charge, :integer
    add_column :orders, :payment_method, :integer
    remove_column :users, :name, :string
  end
end
