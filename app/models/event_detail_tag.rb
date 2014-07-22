class EventDetailTag < ActiveRecord::Base
  belongs_to :event_detail
  belongs_to :tag

end
