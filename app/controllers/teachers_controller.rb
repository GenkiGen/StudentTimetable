class TeachersController < ApplicationController
    before_action :logged_in, only: [:show, :index]

    def new
        @teacher = Teacher.new
    end

    def index
        @teachers = Teacher.paginate(page: params[:page])
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

    def show
        @teacher = Teacher.find_by(id: params[:id])
        @courses = @teacher.courses.all.paginate(page: params[:page], per_page: 20)
    end

    private
        def teacher_params
            params.require(:teacher).permit(:name, :email, :password,
                                            :password_confirmation, :time_zone,
                                            :admin)
        end

        def logged_in
            unless logged_in?
                flash[:danger] = 'Please log in first'
                remember_location
                redirect_to login_path
            end
        end
end
