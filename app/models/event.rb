class Event < ActiveRecord::Base
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

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def self.of_types type_ids
    where_clause = type_ids.map {|type_id| "event_types.id = " + type_id.to_s + " " }.join(" OR ")
    events = Event.joins(:type, :event_details).where(where_clause).order('event_details.start_date ASC')    
    return events
  end

end
