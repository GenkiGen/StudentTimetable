class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        user = User.new(user_params)
        if user.save
            UserMailer.account_activation(user).deliver_now
            flash[:success] = 'Please activate your account via the email we sent you'
            redirect_to root_path
        else
            #Error
            render 'new'
        end
    end

    def show
        @user = User.find_by(id: params[:id])
    end

    private
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation, :time_zone)
        end
end
