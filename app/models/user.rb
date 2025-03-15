class User < ApplicationRecord
  has_secure_password  # This requires a 'password_digest' column
  has_many :entries, dependent: :destroy
end
