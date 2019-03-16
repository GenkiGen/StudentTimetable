module LearnersHelper
    BLOCK = 75
    ROOT = Time.parse("08:00")

    def set_time_zone(timezone)
        Time.zone = timezone
    end

    def calculate_position(record)
        start_minutes = calculate_minutes(record.start_time)
        root_minutes = calculate_minutes(ROOT)
        difference = start_minutes - root_minutes
        position = "#{(difference.to_f / 60 * BLOCK).abs}px"
    end

    def calculate_height(record)
        #Get start time in minutes
        start_minutes = calculate_minutes(record.start_time)
        #Get end time in minutes
        end_minutes = calculate_minutes(record.end_time)
        difference = end_minutes - start_minutes
        height = "#{(difference.to_f / 60 * BLOCK).abs}px"
    end

    def calculate_minutes(time)
        time.hour * 60 + time.min - time.utc_offset / 60
    end

    def getScheduleFromDay(records, day)
        records.filter { |sch| sch.day == day }
    end
end
