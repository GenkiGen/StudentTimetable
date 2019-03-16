class LearnersController < ApplicationController
    def new
        @learner = Learner.new
    end
    
    def index
        @learners = Learner.paginate(page: params[:page])
    end

    def create
        @learner = Learner.create(learner_params)
        if @learner.save
            UserMailer.account_activation(@learner).deliver_now
            flash[:success] = "Please activate the account using the link we sent to your email"
            redirect_to root_path
        else
            render 'new'
        end
    end

    def show
        @learner = Learner.find_by(id: params[:id])
        @following_courses = @learner.following_courses.paginate(page: params[:page], per_page: 10)
    end

    def timetable
        @learner = Learner.find_by(id: params[:id])
        @monday = @learner.schedules.where('day = ?', 'Monday')
        @tuesday = @learner.schedules.where('day = ?', 'Tuesday')
        @wednesday = @learner.schedules.where('day = ?', 'Wednesday')
        @thursday = @learner.schedules.where('day = ?', 'Thursday')
        @friday = @learner.schedules.where('day = ?', 'Friday')
        @saturday = @learner.schedules.where('day = ?', 'Saturday')
        @sunday = @learner.schedules.where('day = ?', 'Sunday')
    end

    private 
        def learner_params
            params.require(:learner).permit(:name, :email, :password,
                                         :password_confirmation, :time_zone)
        end
end
