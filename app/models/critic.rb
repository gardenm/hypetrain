class Critic < ActiveRecord::Base
  has_many :reviews
  attr_accessible :link, :name
end
