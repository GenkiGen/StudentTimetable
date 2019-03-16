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

    # This function checks if the target course
    # has overlapped with the exsiting coursess
    # that a learner has
    def has_overlapped_courses(course)
        self.following_courses.each do |current|
            # Fo each day of the week
            Date::DAYNAMES.each do |day_of_week|
                schedules1 = course.schedules
                                   .where('day = ?', day_of_week)
                schedules2 = current.schedules
                                   .where('day = ?', day_of_week)
                return true unless has_not_overlapped(schedules1, schedules2) 
            end
        end

        false
    end

    private
        def has_not_overlapped(schedules1, schedules2)
            index1 = 0
            index2 = 0
        
            while index1 < schedules1.length && index2 < schedules2.length
                current1 = schedules1[index1]
                current2 = schedules2[index2]
        
                if ((current1.end_time >= current2.start_time) && (current1.end_time <= current2.end_time)) || ((current2.end_time >= current1.start_time) && (current2.end_time <= current1.end_time))
                    return false
                end
        
                current1.start_time > current2.start_time ? index2 += 1 : index1 += 1
            end
        
            true
        end
end
