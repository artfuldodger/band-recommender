class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :name, :username, :password, :picture
  
  validates_presence_of :password, on: :create
  validates :name, :username, presence: true
  validates :username, uniqueness: true
  has_many :ratings
  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }
end
