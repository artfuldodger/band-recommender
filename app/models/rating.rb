class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :band
  attr_accessible :band, :score
end
