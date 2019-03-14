class Schedule < ApplicationRecord
    belongs_to :course
    validate :start_time_must_before_end_time

    def Schedule.parse(time_string)
        Time.parse(time_string)
    end

    private
        def start_time_must_before_end_time
            unless start_time < end_time
                errors.add(:start_time, 'must be before end time')
            end
        end
end
