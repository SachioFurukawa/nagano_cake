class AddColumnsToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :genre_id, :integer
    add_column :items, :name, :string
    add_column :items, :introduction, :text
    add_column :items, :image_id, :string
    add_column :items, :price, :integer
  end
end
