class User < ApplicationRecord
  before_create :set_user_api_key

  validates :email, uniqueness: true, presence: true
  validates :password, presence: { require: true }
  validates :password_confirmation, presence: { require: true }

  has_secure_password

  private

  def set_user_api_key
    self.api_key = SecureRandom.urlsafe_base64
  end
end
