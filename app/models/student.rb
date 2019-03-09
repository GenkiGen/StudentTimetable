class Student < ApplicationRecord
    # Has a secure password
    has_secure_password
    # Validation
    validates :name, presence: true, length: { minimum: 5 }
    validates :email, presence: true, length: { minimum: 5 },
                                      format: { with: /\A[A-z0-9\-]+@[A-z0-9\-]+(\.[A-z0-9]+)+\z/i }
    validates_with PasswordValidator
    # Validate time zone
    validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.all.map(&:name)
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
