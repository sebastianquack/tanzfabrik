module Api  
  class StudiosController < ApplicationController
    def index
      now = DateHelper.to_iso_date_string(Date.today)
  
      booking_type = BookingType.find_by(name: params[:booking_type])
      calendar = Calendar.find_by(studio_id: params[:id])
      availabilities = calendar.get_availabilities(now, booking_type)

      render json: availabilities
    end

    def by_booking_type
      calendars = BookingType.find_by(name: params[:booking_type]).calendars
      
      studios = calendars.map do |c| 
        {
          id: c.studio.id, 
          name: c.studio.fullname, 
          description: c.studio.rich_content_en.body, 
          image: {
            url: c.studio.images[0].attachment.url(:medium),
            alt: c.studio.images[0].description
          } ,
          address: c.studio.location.address
        }
      end

      render json: studios
    end
  end
end