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

    private 
        def learner_params
            params.require(:learner).permit(:name, :email, :password,
                                         :password_confirmation, :time_zone)
        end
end
