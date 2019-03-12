class Learner < User
    has_many :following_courses, class_name: 'Course', source: :Course
    has_many :teachers, through: :following_courses

    def follow_course(course)
        following_courses << course
    end

    def unfollow_course(course)
        follow_course.delete(course)
    end
end
