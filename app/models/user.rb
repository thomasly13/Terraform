class User < ApplicationRecord
    validates :session_token, presence: true, uniqueness: true 
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "can't be an email"}, length: { in: 3..255}
    validates :username, presence: true, format: { in: 3..30 }, uniqueness: true 
    validates :password_digest, :first_name, :last_name, presence: true
    validates :password, length: {in: 6..255}, allow_nil: true 

    before_validation :ensure_session_token

    has_secure_password

    
    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
        if user && user.authenticate(password)
            return user
        end
        nil
    end

    def ensure_session_token
        self.session_token ||= generate_unique_session_token
    end

    def reset_session_token!
        self.session_token = generate_unique_session_token
        self.save!
        self.session_token
    end

    private 

    def generate_unique_session_token
        while true
            token = SecureRandom.urlsafe_base64
            return token unless User.exists?(session_token: token)
        end
    end
end
