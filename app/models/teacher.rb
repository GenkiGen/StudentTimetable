class Teacher < User
    has_many :courses
    
    def add_course(course)
        courses << course
    end

    def remove_course(course)
        courses.delete(course)
    end
end