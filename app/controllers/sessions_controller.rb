class SessionsController < ApplicationController
    def new
    end

    def create
        # Get student
        student = Student.find_by(email: params[:student][:email])
        if student && student.authenticate(params[:student][:password])
            login student
            flash[:success] = 'You have logged in'
            redirect_to student
        else
            flash[:danger] = 'Invalid email/password combination'
            render 'new'
        end
    end
end
