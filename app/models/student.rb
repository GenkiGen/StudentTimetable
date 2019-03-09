class Student < ApplicationRecord
    # Relationship with students
    has_many :student_course_relationships
    has_many :courses, through: :student_course_relationships
    # Relationship with sessions
    has_many :sessions, through: :courses

    def add_course(course)
        courses << course
    end

    def remove_course(course)
        courses.delete(course)
    end
end
