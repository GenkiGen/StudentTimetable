class StudentsController < ApplicationController
    def new
        @student = Student.new
    end

    def create
        @student = Student.new(student_params)
        if @student.save
            #Success
            flash[:success] = 'Your account has been created'
            redirect_to student_path(@student)
        else
            #Error
            render 'new'
        end
    end

    def show
        @student = Student.find_by(id: params[:id])
    end

    private
        def student_params
            params.require(:student).permit(:name, :email, :password, :password_confirmation, :time_zone)
        end
end
