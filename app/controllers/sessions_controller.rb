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
            redirect_to user_path(user)
        else
            flash[:danger] = 'Invalid email/password combination'
            render 'new'
        end
    end
end
