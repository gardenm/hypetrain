class Review < ActiveRecord::Base
  belongs_to :album
  belongs_to :critic
  attr_accessible :description, :link, :pub_date, :source
end
