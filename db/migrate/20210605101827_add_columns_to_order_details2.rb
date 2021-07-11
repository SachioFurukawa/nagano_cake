class AddColumnsToOrderDetails2 < ActiveRecord::Migration[5.2]
  def change
    add_column :order_details, :making_status, :integer
  end
end
