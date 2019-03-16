class ApplicationController < ActionController::Base
    include SessionsHelper
    around_action :user_time_zone

    private 
        def user_time_zone(&block)
            time_zone = current_user.nil? ? "Hanoi" : current_user.time_zone
            Time.use_zone(time_zone, &block)
        end
end
