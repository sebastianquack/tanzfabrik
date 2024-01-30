module Api  
  class StudiosController < ApplicationController
    def index
      now = DateHelper.to_iso_date_string(Date.today)
  
      booking_type = BookingType.find_by(name: params[:booking_type])
      calendar = Calendar.find_by(studio_id: params[:id])
      availability_config = CalendarBookingType.find_by(calendar: calendar, booking_type: booking_type).settings
      availabilities = calendar.get_availabilities(now, availability_config)

      render json: availabilities
    end
  end
end