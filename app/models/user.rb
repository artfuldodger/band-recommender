class User < ActiveRecord::Base
  attr_accessible :name, :username
  validates :name, :username, presence: true
  has_many :ratings
  has_attached_file :picture
end
