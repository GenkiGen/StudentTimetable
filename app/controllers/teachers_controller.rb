class TeachersController < ApplicationController
    def new
        @teacher = Teacher.new
    end

    def create
        @teacher = Teacher.new(teacher_params)
        if @teacher.save
            UserMailer.account_activation(@teacher).deliver_now
            flash[:success] = 'Please activate your account before logging in'
            redirect_to root_path
        else
            render 'new'
        end
    end

    private
        def teacher_params
            params.require(:teacher).permit(:name, :email, :password,
                                            :password_confirmation, :time_zone,
                                            :admin)
        end
end
