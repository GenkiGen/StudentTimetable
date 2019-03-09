class AddTimezoneToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :time_zone, :string
  end
end
