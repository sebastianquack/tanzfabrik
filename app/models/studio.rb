class Studio < ActiveRecord::Base
  translates :description
  
  belongs_to :location

  has_many :event_details
  has_many :events, :through => :event_details

  has_many :images
  accepts_nested_attributes_for :images, :allow_destroy => true
  
end
