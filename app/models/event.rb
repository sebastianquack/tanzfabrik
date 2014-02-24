class Event < ActiveRecord::Base
  belongs_to :type, :class_name => "EventType"
end
