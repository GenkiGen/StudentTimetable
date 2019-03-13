class SessionsController < ApplicationController
    def new
    end

    def create
        # Get user
        user = User.find_by(email: params[:user][:email])
        if user && user.authenticate(params[:user][:password])
            login user
            params[:user][:remember_me] == '1' ? remember(user) : forget(user)
            flash[:success] = 'You have logged in'
            if is_teacher?(user)
                redirect_to teacher_path(user)
            elsif is_learner?(user)
                redirect_to learner_path(user)
            end
        else
            flash[:danger] = 'Invalid email/password combination'
            render 'new'
        end
    end

    def delete
        if logged_in?
            forget(current_user)
            logout
        end
        redirect_to root_path
    end
end
