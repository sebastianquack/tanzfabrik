class EventsTimes < ActiveRecord::Base
  belongs_to :event
  belongs_to :studio
end
