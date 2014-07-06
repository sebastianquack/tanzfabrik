class Festival < ActiveRecord::Base
  translates :name, :description

  has_many :festival_events
  has_many :events, :through => :festival_events
  has_many :event_details, :through => :events

  #accepts_nested_attributes_for :festival_events, :allow_destroy => true
  #accepts_nested_attributes_for :events, :allow_destroy => true

  has_many :images
  accepts_nested_attributes_for :images, :allow_destroy => true
  
  has_many :downloads
  accepts_nested_attributes_for :downloads, :allow_destroy => true

  def startdate
    return "START"
  end

  def enddate
    return "END"
  end
  
end
