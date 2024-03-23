class CalendarEvent <  ActiveRecord::Base
  belongs_to :calendar
  belongs_to :booking
end
