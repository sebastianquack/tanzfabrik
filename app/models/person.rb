class Person < ActiveRecord::Base

  has_many :persons_events, :dependent => :destroy
  has_many :events, :through => :persons_events
  accepts_nested_attributes_for :persons_events, :allow_destroy => true
end
