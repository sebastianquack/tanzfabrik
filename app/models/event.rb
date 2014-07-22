class Event < ActiveRecord::Base
  translates :title, :description, :warning, :info, fallback: :any

  belongs_to :type, :class_name => "EventType"

  has_many :festival_events
  accepts_nested_attributes_for :festival_events, :allow_destroy => true
  
  has_many :festivals, :through => :festival_events
  #accepts_nested_attributes_for :festivals, :allow_destroy => true

  has_many :person_events
  accepts_nested_attributes_for :person_events, :allow_destroy => true
  
  has_many :people, :through => :person_events
  accepts_nested_attributes_for :people, :allow_destroy => true

  has_many :event_tags
  #accepts_nested_attributes_for :event_tags, :allow_destroy => true  

  has_many :tags, :through => :event_tags
  accepts_nested_attributes_for :tags, :allow_destroy => true

  has_many :event_details, :dependent => :destroy
  accepts_nested_attributes_for :event_details, :allow_destroy => true

  has_many :images
  accepts_nested_attributes_for :images, :allow_destroy => true

  validates_numericality_of :price_regular,
      :only_integer => true

  validates_numericality_of :price_reduced,
      :only_integer => true      
  
  def self.of_types type_ids
    where_clause = type_ids.map {|type_id| "event_types.id = " + type_id.to_s + " " }.join(" OR ")
    events = Event.joins(:type, :event_details).group('events.id').where(where_clause)
    return events
  end

  def all_studios
    studios = []
    self.event_details.each { |ed| studios << ed.studio }
    return studios.uniq
  end

  def firsttime studio
    ft = new Time()
    self.event_details.each do |ed|
      if ed.studio == studio
        if ed.starttime < ft
          ft = ed.starttime
        end
      end
    end
    return ft
  end

end
