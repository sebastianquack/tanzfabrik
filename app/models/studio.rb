class Studio < ActiveRecord::Base
  belongs_to :location
  has_many :images  
end
