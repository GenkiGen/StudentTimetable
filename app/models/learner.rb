class Learner < User
    has_many :learner_course_relationships
    has_many :following_courses, -> {distinct},through: :learner_course_relationships, class_name: 'Course', source: :course
    has_many :teachers, through: :following_courses
    has_many :schedules, through: :following_courses

    def follow_course(course)
        following_courses << course
    end

    def unfollow_course(course)
        following_courses.delete(course)
    end
end
