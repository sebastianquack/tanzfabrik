class Festival < ActiveRecord::Base
  translates :name, :description

  extend FriendlyId
  friendly_id :name_de, use: [:slugged, :finders]

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
    if self.events.length > 0
      return self.events.min_by { |e| e.start_date} .start_date
    else
      return nil
    end
  end

  def end_date
    if self.events.length > 0
      return self.events.max_by { |e| e.end_date } .end_date
    else
      return nil
    end
  end
  
  def in_menu? date=Date.today
    return false if self.events.empty?
    return self.end_date >= date
  end

  def self.in_menu date=Date.today
    return self.select{ |f| f.in_menu? date }
  end

end
