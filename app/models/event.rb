class Event < ActiveRecord::Base
  belongs_to :type, :class_name => "EventType"

  has_many :festival_events
  #accepts_nested_attributes_for :festival_events, :allow_destroy => true
  
  has_many :festivals, :through => :festival_events
  #accepts_nested_attributes_for :festivals, :allow_destroy => true

  has_many :person_events
  #accepts_nested_attributes_for :person_events, :allow_destroy => true
  
  has_many :people, :through => :person_events
  #accepts_nested_attributes_for :people, :allow_destroy => true

  has_many :event_times
  accepts_nested_attributes_for :event_times, :allow_destroy => true

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
