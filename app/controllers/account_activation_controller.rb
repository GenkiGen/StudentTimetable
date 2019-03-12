class AccountActivationController < ApplicationController
    def edit
        user = User.find_by(email: params[:email])
        if user && !user.activated && user.authenticate?(:activation, params[:id])
            user.activate
            login user
            flash[:success] = 'Your account has been activated'
            redirect_to user_path(user)
        else
            flash[:danger] = 'Invalid activation link'
            redirect_to root_path
        end
    end
end
