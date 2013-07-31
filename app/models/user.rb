class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :first_name, :last_name, :username, :game_id, :value, :password_confirmation, :password
  has_many :scores
  # validates :email, presence: true, uniqueness: true
end
