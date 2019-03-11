class Student < ApplicationRecord
    attr_accessor :activation_token, :activation_digest
    before_create :create_activation_digest

    # Has a secure password
    has_secure_password
    # Validation
    validates :name, presence: true, length: { minimum: 5 }
    validates :email, presence: true, length: { minimum: 5 },
                                      format: { with: /\A[A-z0-9\-]+@[A-z0-9\-]+(\.[A-z0-9]+)+\z/i }
    validates_with PasswordValidator
    # Validate time zone
    validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.all.map(&:name)
    # Relationship with students
    has_many :student_course_relationships
    has_many :courses, through: :student_course_relationships
    # Relationship with sessions
    has_many :sessions, through: :courses

    def add_course(course)
        courses << course
    end

    def remove_course(course)
        courses.delete(course)
    end

    def Student.new_token
        SecureRandom.urlsafe_base64.to_s
    end

    def Student.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    private
        def create_activation_digest
            self.activation_token = Student.new_token
            self.activation_digest = Student.digest(self.activation_token)
        end
end
