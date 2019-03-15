class AddDayOfWeekToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :day, :string
  end
end
