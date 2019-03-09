class Course < ApplicationRecord
    # Relationship with student
    has_many :student_course_relationships
    has_many :students, through: :student_course_relationships
    # Relationship with session
    has_many :sessions
end
