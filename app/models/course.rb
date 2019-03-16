class Course < ApplicationRecord
    belongs_to :teacher
    validates :name, presence: true
    validates :code, presence: true
    # Relationship with users
    has_many :learner_course_relationships
    has_many :following_learners, -> { distinct },through: :learner_course_relationships, class_name: 'Learner', source: :learner
    # Relationhip with schedules
    has_many :schedules, -> { distinct }
    # Uploader
    mount_uploader :picture, ::PictureUploader
    validate :avatar_size

    # Search
    def self.search(course_name)
        Course.where('name LIKE ?', "%#{course_name}%")
    end

    def add_schedule(schedule)
        schedules << schedule unless schedules.include?(schedule)
        return schedule.save
    end

    def remove_schedule(schedule)
        schedules.delete(schedule)
    end

    private 
        def avatar_size
            unless picture.size < 5.megabytes 
                errors.add(:picture, 'should be smaller than 5MB')
            end
        end
end
