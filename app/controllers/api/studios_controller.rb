module Api  
  class StudiosController < ApplicationController
    def index
      now = to_iso_date(Date.today)
      to = to_iso_date(Date.today >> 1)
      puts now
      puts to
      @availabilities = Calendar.all.first.events.where("start_time >= ? AND end_time <= ?", now, to)
      render json: @availabilities
    end
    private
    def to_iso_date(date)
      Time.utc(date.year, date.month, date.day, 0, 0, 0).strftime("%Y-%m-%dT%H:%M:%S")
    end
  end
end