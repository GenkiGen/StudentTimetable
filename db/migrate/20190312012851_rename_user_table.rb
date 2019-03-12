class RenameUserTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :students, :users
  end
end
