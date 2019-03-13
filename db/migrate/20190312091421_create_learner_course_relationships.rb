class CreateLearnerCourseRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :learner_course_relationships do |t|
      t.integer :learner_id
      t.integer :course_id

      t.timestamps
    end
  end
end
