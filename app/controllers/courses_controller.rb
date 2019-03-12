class CoursesController < ApplicationController
    before_action :logged_in, only: [:new, :create, :follow]
    before_action :teacher_logged_in, only: [:new, :create]
    before_action :learner_logged_in, only: [:follow]

    def new
        @course = Course.new
    end

    def create
        @course = Course.new(course_params)
        if current_user.add_course(@course)
            flash[:success] = 'Course created'
            redirect_to root_path
        else
            render 'new'
        end
    end

    def index
        @courses = Course.all
    end

    def follow
        @course = Course.find(id: params[:id])
        current_user.follow_course(@course)
        redirect_to 'index'
    end

    private
        def logged_in
            unless logged_in?
                redirect_to login_path
                flash[:danger] = 'Please log in to your account'
            end
        end

        def teacher_logged_in
            unless is_teacher?
                redirect_to login_path
                flash[:danger] = 'Please log in as a teacher'
            end
        end

        def learner_logged_in
            unless is_learner?
                redirect_to login_path
                flash[:danger] = 'Please log in as a learner'
            end
        end

        def course_params
            params.require(:course).permit(:name, :code)
        end
end
