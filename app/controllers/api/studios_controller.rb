module Api  
  class StudiosController < ApplicationController
    def index
      open_time = 

      now = to_iso_date_string(Date.today)
      to = to_iso_date_string(Date.today >> 2)
      booked_slots = Calendar.all.first.events.where("start_time >= ? AND end_time <= ?", now, to).order(start_time: :asc)
      calendar = build_calendar_availabilities(14, booked_slots)
      render json: {calendar: calendar, booked_slots: booked_slots}
    end

    private

    def to_iso_date_time(date)
      Time.utc(date.year, date.month, date.day, 0, 0, 0).strftime("%Y-%m-%dT%H:%M:%S")
    end

    def from_iso_datetime_string(datetime_string)
      DateTime.parse(datetime_string)
    end

    def to_iso_date_string(date)
      Time.utc(date.year, date.month, date.day).strftime("%Y-%m-%d")
    end

    def is_same_day(date1, date2)
      date1.year == date2.year && date1.month == date2.month && date1.day == date2.day
    end

    def build_calendar_availabilities(days_forward, reservations)
      opening_hour = 4
      closing_hour = 23
      slot_time = 2
      
      cur_day = Date.today

      calendar = {}
      
      res_pointer = 0;
      next_reservation = reservations[res_pointer]
      
      days_forward.times do |i|
        date = cur_day + i
        calendar[date] = []
        cur_time = DateTime.new(date.year, date.month, date.day, opening_hour, 0, 0)
        closes_at = DateTime.new(date.year, date.month, date.day, closing_hour, 0, 0)
        
        while cur_time + Rational(slot_time, 24) <= closes_at
          next_reservation_start_time = from_iso_datetime_string(next_reservation.start_time.to_s)
          next_reservation_end_time = from_iso_datetime_string(next_reservation.end_time.to_s)
          Rails.logger.warn("#{cur_time}")
          Rails.logger.warn("#{next_reservation_start_time} - #{next_reservation_end_time}")

          if cur_time + Rational(slot_time, 24) <= next_reservation_start_time
            calendar[date] << cur_time
            cur_time = cur_time + Rational(slot_time, 24)
          else
            cur_time = next_reservation_end_time
            res_pointer += 1
            next_reservation = reservations[res_pointer]
          end
        end
        Rails.logger.warn("__________________________________________")
      end

      return calendar
    end
  end
end