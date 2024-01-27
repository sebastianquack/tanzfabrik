class Calendar < ActiveRecord::Base
  belongs_to :studio
  has_many :bookings
  has_many :events, class_name: :CalendarEvent
end