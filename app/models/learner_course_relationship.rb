class LearnerCourseRelationship < ApplicationRecord
    belongs_to :learner
    belongs_to :course
end
