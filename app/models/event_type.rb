class EventType < ActiveRecord::Base
  has_many :events, class_name: "Event", foreign_key: "type_id"

end
