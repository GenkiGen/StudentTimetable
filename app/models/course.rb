class Course < ApplicationRecord
    belongs_to :teacher
    validates :name, presence: true
    validates :code, presence: true
    # Relationship with users
    has_many :learner_course_relationships
    has_many :following_learners, -> { distinct },through: :learner_course_relationships, class_name: 'Learner', source: :learner
    # Uploader
    mount_uploader :picture, ::PictureUploader
    validate :avatar_size

    private 
        def avatar_size
            unless picture.size < 5.megabytes 
                errors.add(:picture, 'should be smaller than 5MB')
            end
        end
end
