class EventsTags < ActiveRecord::Base
  belongs_to :event
  belongs_to :tag
end
