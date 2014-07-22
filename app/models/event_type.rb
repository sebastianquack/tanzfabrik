class EventType < ActiveRecord::Base
  has_many :event_details, class_name: "EventDetail", foreign_key: "type_id"
  translates :name
end
