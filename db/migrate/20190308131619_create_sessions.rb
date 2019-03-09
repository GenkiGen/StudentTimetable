class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.integer :course_id
      t.time :start_at
      t.time :end_at

      t.timestamps
    end
  end
end
