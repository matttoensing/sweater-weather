class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :password, presence: true
  validates :password, confirmation: { case_sensitive: true }
  validates :api_key, confirmation: { case_sensitive: true }, uniqueness: true

  has_secure_password
  has_secure_token :api_key
end
