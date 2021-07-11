class RenameStatusColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :status, :is_deleted
    change_column :users, :is_deleted,:boolean, default: false
  end

end