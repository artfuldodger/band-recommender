class User < ActiveRecord::Base
  attr_accessible :name, :username
  validates :name, :username, presence: true
end
