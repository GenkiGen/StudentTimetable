module SessionsHelper
    def login(student)
        session[:student_id] = student.id
    end

    def current_student
        if session[:student_id]
            @current_student ||= Student.find_by(id: session[:student_id])
        end
    end

    def logged_in?
        return !current_student.nil?
    end
end
