class Album < ActiveRecord::Base
  belongs_to :artist
  attr_accessible :release_date, :title
end
