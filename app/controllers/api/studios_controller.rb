module Api  
  class StudiosController < ApplicationController
    def index
      availabilities = Calendar.all.first.get_availabilities()            
      render json: availabilities
    end
  end
end