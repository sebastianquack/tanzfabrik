class Tag < ActiveRecord::Base
  translates :name

  has_many :event_tags
  has_many :events, :through => :event_tags  
end
