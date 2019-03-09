class CreateStudentCourseRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :student_course_relationships do |t|
      t.integer :student_id
      t.integer :course_id

      t.timestamps
    end
  end
end
