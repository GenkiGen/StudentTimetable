class User < ApplicationRecord
    attr_accessor :activation_token
    attr_accessor :login_token
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

    def User.new_token
        SecureRandom.urlsafe_base64.to_s
    end

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # Remember when logged in
    def remember
        self.login_token = User.new_token
        update_attribute(:login_digest, User.digest(self.login_token))
    end

    def forget
        self.login_token = nil
        update_attribute(:login_digest, nil)
    end

    def authenticate?(attribute, token)
        digest = self.send("#{attribute}_digest")
        return false if digest.nil?
        return BCrypt::Password.new(digest).is_password?(token)
    end

    def activate
        update_attribute(:activated, true)
        update_attribute(:activated_at, Time.zone.now)
    end

    private
        def create_activation_digest
            self.activation_token = User.new_token
            self.activation_digest = User.digest(self.activation_token)
        end
end
