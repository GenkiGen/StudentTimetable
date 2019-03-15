class SchedulesController < ApplicationController
    before_action :logged_in, only: [:new]
    before_action :teacher_logged_in, only: [:new]
    before_action :owner_logged_in, only: [:new]

    def new
        @course ||= Course.find_by(id: params[:id])
        @schedule = @course.schedules.new
    end

    def create
        @course ||= Course.find_by(id: params[:id])
        @schedule = @course.schedules.new(schedule_params)
        if @schedule.save
            flash[:success] = 'Added a schedule to your courses'
            redirect_to course_path(@course)
        else
            render 'new'
        end
    end

    private 
        def logged_in
            unless logged_in?
                flash[:danger] = 'Please log in first'
                remember_location
                redirect_to login_path
            end
        end

        def teacher_logged_in
            unless is_teacher?
                flash[:danger] = 'You have to be a teacher to make schedule'
                remember_location
                redirect_to login_path
            end
        end

        def owner_logged_in
            @course = current_user.courses.find_by(id: params[:id])
            unless @course
                flash[:danger] = 'You have to be the course owner to add schdule'
                remember_location
                redirect_to login_path
            end
        end

        def schedule_params
            all_params = params.require(:schedule).permit(:start_time, :end_time)
            all_params[:start_time] = Schedule.parse(all_params[:start_time])
            all_params[:end_time] = Schedule.parse(all_params[:end_time])
            all_params
        end
end
