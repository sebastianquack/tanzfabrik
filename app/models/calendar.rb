class Calendar < ActiveRecord::Base
  belongs_to :studio
  has_many :bookings
  has_many :calendar_events
end