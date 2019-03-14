class CoursesController < ApplicationController
    before_action :logged_in, only: [:new, :create, :follow, :index]
    before_action :correct_user, only: [:delete]
    before_action :teacher_logged_in, only: [:new, :create]
    before_action :learner_logged_in, only: [:follow]

    def new
        @course = Course.new
    end

    def show
        @course = Course.find_by(id: params[:id])
    end

    def create
        @course = Course.new(course_params)
        if current_user.add_course(@course)
            flash[:success] = 'Course created'
            redirect_to teacher_path(current_user)
        else
            render 'new'
        end
    end

    def delete
        @course ||= Course.find_by(id: params[:id])
        @course.destroy
        flash[:primary] = 'You have deleted a course'
        redirect_to current_user
    end

    def index
        @courses = get_course_and_sort(params[:sort])
    end

    def follow
        @course = Course.find_by(id: params[:id])
        unless followed_course(@course)
            current_user.follow_course(@course)
            flash[:success] = 'You have followed this course'
        else
            flash[:danger] = 'You have already follow this course'
        end
        redirect_to learner_path(current_user)
    end

    def unfollow
        @course = Course.find_by(id: params[:id])
        if followed_course(@course)
            current_user.unfollow_course(@course)
            flash[:success] = 'You have unfollow this course'
        else
            flash[:danger] = 'You have not follow this course yet'
        end
        redirect_to learner_path(current_user)
    end

    private
        def logged_in
            unless logged_in?
                redirect_to login_path
                remember_location
                flash[:danger] = 'Please log in to your account'
            end
        end

        def teacher_logged_in
            unless is_teacher?
                redirect_to login_path
                remember_location
                flash[:danger] = 'Please log in as a teacher'
            end
        end

        def learner_logged_in
            unless is_learner?
                redirect_to login_path
                remember_location
                flash[:danger] = 'Please log in as a learner'
            end
        end
        
        def correct_user
            @course = current_user.courses.find_by(id: params[:id])
            if @course.nil?
                flash[:message] = 'Please log in as course owner'
                redirect_to login_path
            end
        end

        def course_params
            params.require(:course).permit(:name, :code, :picture)
        end

        def get_course_and_sort(by = nil) 
            by ||= 'date'
            case by
            when 'popularity'
                Course.joins('LEFT JOIN learner_course_relationships on learner_course_relationships.course_id = courses.id')
                      .group('courses.id')
                      .order('COUNT(learner_course_relationships.learner_id) DESC')
            when 'date'
                Course.order('created_at DESC')
            end
        end
end
