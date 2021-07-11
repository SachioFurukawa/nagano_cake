class ChangeDataAddressToOrders < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :address, :string
  end
end
