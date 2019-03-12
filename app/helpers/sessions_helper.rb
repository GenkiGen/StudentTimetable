module SessionsHelper
    def login(user)
        session[:user_id] = user.id
    end

    def is_teacher?
        current_user.type == 'Teacher'
    end

    def is_learner?
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
end
