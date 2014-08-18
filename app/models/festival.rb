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


  def start_date
    return self.events.min_by { |e| e.start_date} .start_date
  end

  def end_date
    return self.events.max_by { |e| e.end_date } .end_date
  end
  
  def in_menu? date=Date.today
    return false if self.events.empty?
    return self.end_date > date
  end

  def self.in_menu date=Date.today
    return self.select{ |f| f.in_menu? date }
  end

end
