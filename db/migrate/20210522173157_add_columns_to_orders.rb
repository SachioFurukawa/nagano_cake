class AddColumnsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :user_id, :integer
    add_column :orders, :address, :integer
    add_column :orders, :status, :integer
  end
end
