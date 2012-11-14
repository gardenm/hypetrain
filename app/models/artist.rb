class Artist < ActiveRecord::Base
  has_many :albums
  attr_accessible :name
end
