class Event < ActiveRecord::Base
  belongs_to :type, :class_name => "EventType"

  has_many :festivals_events, :dependent => :destroy
  has_many :festivals, :through => :festivals_events
  accepts_nested_attributes_for :festivals_events, :allow_destroy => true

  has_many :persons_events, :dependent => :destroy
  has_many :people, :through => :persons_events
  accepts_nested_attributes_for :persons_events, :allow_destroy => true

end
