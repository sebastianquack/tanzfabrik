module Api  
  class StudiosController < ApplicationController
    def index
      now = DateHelper.to_iso_date_string(Date.today)
      to = DateHelper.to_iso_date_string(Date.today >> 12)
      availabilities = Calendar.find_by(studio_id: params[:id]).get_availabilities(now, to)            
      render json: availabilities
    end
  end
end