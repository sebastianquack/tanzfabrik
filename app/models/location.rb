class Location < ActiveRecord::Base
  has_many :studios
  has_many :events, :through => :studios
  has_many :event_times, :through => :studios
end
