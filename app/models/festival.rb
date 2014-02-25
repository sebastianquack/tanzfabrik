class Festival < ActiveRecord::Base

  has_many :festivals_events, :dependent => :destroy
  has_many :events, :through => :festivals_events

  accepts_nested_attributes_for :festivals_events, :allow_destroy => true
end
