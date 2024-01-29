class CalendarBookingType < ActiveRecord::Base
  belongs_to :calendar
  belongs_to :booking_type
  
  serialize :settings, JSON  
end
