class User < ApplicationRecord
    validates :session_token, presence: true, uniqueness: true 
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP}, length: { in: 3..255}
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :username, presence: true, format: { in: 3..30 }
end
