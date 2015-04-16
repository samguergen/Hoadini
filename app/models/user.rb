class User < ActiveRecord::Base
  has_secure_password
  has_many :favorite_properties
  has_many :user_preferences

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
