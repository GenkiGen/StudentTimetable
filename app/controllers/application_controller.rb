class ApplicationController < ActionController::Base
    include SessionsHelper
    around_action :user_time_zone, if: :current_user

    private 
        def user_time_zone(&block)
            Time.use_zone(current_user.time_zone, &block)
        end
end
