class Artist < ActiveRecord::Base
  has_many :albums
  attr_accessible :name
  
  validates_uniqueness_of :name
end
