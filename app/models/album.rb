class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :reviews
  attr_accessible :release_date, :title
end
