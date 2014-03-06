class Location < ActiveRecord::Base
  translates :description

  has_many :studios
  has_many :events, :through => :studios
  has_many :event_details, :through => :studios
end
