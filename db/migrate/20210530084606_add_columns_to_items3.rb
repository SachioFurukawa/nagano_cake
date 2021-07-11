class AddColumnsToItems3 < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :is_active, :boolean, default: false
  end
end