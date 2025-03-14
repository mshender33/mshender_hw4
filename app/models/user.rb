class User < ApplicationRecord
  has_secure_password  # Enables bcrypt for password encryption
  has_many :entries, dependent: :destroy
end
