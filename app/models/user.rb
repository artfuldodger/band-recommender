class User < ActiveRecord::Base
  attr_accessible :name, :username
  validates :name, :username, presence: true
  has_many :ratings
  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }
end
