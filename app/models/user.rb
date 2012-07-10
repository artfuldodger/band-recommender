class User < ActiveRecord::Base
  attr_accessible :name, :password_digest, :username
  validates :name, :username, presence: true
end
