class AddColumnsToAddress < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :user_id, :integer
    add_column :addresses, :name, :string
    add_column :addresses, :postal_code, :string
    add_column :addresses, :address, :string
  end
end
