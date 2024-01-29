class BookingType < ActiveRecord::Base
  has_many :calendar_booking_types
  has_many :calendars, through: :calendar_booking_types

  def self.two_hour_rehearsal
    booking_type = BookingType.where(name: "Rehearsal 2hrs").first_or_initialize
    booking_type.update({name: "Rehearsal 2hrs", price_per: "700", time: "2 hours"})
    booking_type.save()
    booking_type
  end

end
