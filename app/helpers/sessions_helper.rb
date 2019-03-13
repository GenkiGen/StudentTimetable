module SessionsHelper
    def login(user)
        session[:user_id] = user.id
    end

    def logout
        @current_user = nil
        session.delete(:user_id)
    end

    def is_current_user?(user)
        current_user == user
    end

    def is_teacher?(user = nil)
        user ||= current_user
        current_user.type == 'Teacher'
    end

    def is_learner?(user = nil)
        user ||= current_user
        current_user.type == "Learner"
    end

    def current_user
        if (id = session[:user_id])
            @current_user ||= User.find_by(id: id)
        elsif (id = cookies.signed[:user_id])
            user = User.find_by(id: id)
            if user && user.authenticate?(:login, cookies[:login_token])
                @current_user ||= user
            end
        end
    end

    def logged_in?
        return !current_user.nil?
    end

    def remember(user)
        cookies.permanent.signed[:user_id] = user.id
        user.remember
        cookies.permanent[:login_token] = user.login_token
    end

    def forget(user)
        cookies.delete(:user_id)
        user.forget
        cookies.delete(:login_token)
    end

    def followed_course(course)
        !current_user.following_courses.find_by(id: course.id)
                                      .nil?
    end

    def remember_location
        session[:url] = request.original_url if request.get?
    end

    def redirect_or(default)
        redirect_to(session[:url] ? session[:url] : default)
        session.delete(:url)
    end
end
