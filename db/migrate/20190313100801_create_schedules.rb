class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.integer :course_id
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
