class Band < ActiveRecord::Base
  attr_accessible :description, :name
  validates :name, presence: true
  has_many :ratings
  has_attached_file :picture
end
