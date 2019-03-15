class Schedule < ApplicationRecord
    belongs_to :course
    validate :start_time_must_before_end_time
    validate :has_not_overlapped

    def Schedule.parse(time_string)
        Time.parse(time_string)
    end

    def to_s
        result = "Schedule: starts at #{start_time.strftime("%H:%M %P")}, ends at #{end_time.strftime("%H:%M %P")}."
    end

    private
        def start_time_must_before_end_time
            unless start_time < end_time
                errors.add(:start_time, 'must be before end time')
            end
        end

        def has_not_overlapped
            schedule_before = course.schedules
                                    .where('start_time <= ?', start_time)
                                    .order(:start_time)
                                    .last
            
            schedule_after = course.schedules
                                   .where('start_time > ?', start_time)
                                   .order(:start_time)
                                   .first
            
            unless (schedule_before.nil? || schedule_before.end_time <= start_time) 
                errors.add(:start_time, "has collided with #{schedule_before.to_s}")
            end

            unless (schedule_after.nil? || schedule_after.start_time >= end_time)
                errors.add(:end_time, "has collided with #{schedule_after.to_s}")
            end
        end
end
