class SchedulesController < ApplicationController
    before_action :logged_in, only: [:new, :create, :delete]
    before_action :teacher_logged_in, only: [:new, :create, :delete]
    before_action :owner_logged_in, only: [:new, :create, :delete]

    def new
        @course ||= Course.find_by(id: params[:id])
        @schedule = @course.schedules.new
    end

    def create
        @course ||= Course.find_by(id: params[:id])
        @schedule = @course.schedules.new(schedule_params)
        if @course.add_schedule(@schedule)
            flash[:success] = 'Added a schedule to your courses'
            redirect_to course_path(@course)
        else
            render 'new'
        end
    end

    def delete
        @course ||= Course.find_by(id: params[:id])
        @schedule = Schedule.find_by(id: params[:sch_id])
        @course.remove_schedule(@schedule)
        flash[:success] = 'Schedule deleted successfully'
        redirect_to course_path(@course)
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
            all_params = params.require(:schedule).permit(:start_time, :end_time, :day)
            all_params[:start_time] = Schedule.parse(all_params[:start_time])
            all_params[:end_time] = Schedule.parse(all_params[:end_time])
            all_params
        end
end
