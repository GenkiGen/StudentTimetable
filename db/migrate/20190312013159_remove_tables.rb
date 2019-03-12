class RemoveTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :courses
    drop_table :student_course_relationships
  end
end
