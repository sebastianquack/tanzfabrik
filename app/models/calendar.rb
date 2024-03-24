class Calendar < ActiveRecord::Base
  belongs_to :studio
  has_many :bookings
  has_many :events, class_name: :CalendarEvent
  has_many :availabilities, class_name: :CalendarBookingType
  has_many :booking_types, through: :availabilities

  def get_availabilities(from, booking_type)
    availability_config = CalendarBookingType.find_by(calendar: self, booking_type: booking_type).settings
    to = DateHelper.to_iso_date_string(Date.today >> availability_config["bookable_months_in_advance"])
    upcoming_events = events.where("start_time >= ? AND end_time <= ?", from, to).order(start_time: :asc)
    merged_bookings_by_day = merge_bookings_by_day(upcoming_events)    
    return build_calendar_availabilities(availability_config, merged_bookings_by_day)
  end

  private

  def build_calendar_availabilities(availability_config, reservations_by_day)
    slot_time = 2
    days_forward = availability_config["bookable_months_in_advance"]*30
    calendar = {}

    for i in 0..days_forward do
      cur_day = Date.today + i
      day_of_the_week = cur_day.strftime('%A').downcase
      availability_of_the_day = availability_config["schedule"][day_of_the_week]

      cur_day_key = DateHelper.to_iso_date_string(cur_day)
      calendar[cur_day_key] = []

      if availability_of_the_day.nil?
        next
      end

      opening_hour = availability_of_the_day["from"].to_i
      closing_hour = availability_of_the_day["to"].to_i


      reservations = reservations_by_day[cur_day_key]

      cur_time = DateTime.new(cur_day.year, cur_day.month, cur_day.day, opening_hour, 0, 0)
      closes_at = DateTime.new(cur_day.year, cur_day.month, cur_day.day, closing_hour, 0, 0)

      if reservations.nil?
        while cur_time + Rational(slot_time, 24) <= closes_at
          start_time = DateHelper.berlin_time(cur_time)
          end_time = cur_time + Rational(slot_time, 24)
          calendar[cur_day_key] << {id: SecureRandom.uuid, start: start_time, end: end_time, studio: self.studio_id}
          cur_time += Rational(slot_time, 24)
        end
        next
      end

      r_p = 0
      next_reservation = reservations[r_p]

      while cur_time + Rational(slot_time, 24) <= closes_at
        if next_reservation.nil?
          while cur_time + Rational(slot_time, 24) <= closes_at
            start_time = DateHelper.berlin_time(cur_time)
            end_time = cur_time + Rational(slot_time, 24)
            calendar[cur_day_key] << {id: SecureRandom.uuid, start: start_time, end: end_time, studio: self.studio_id}
            cur_time += Rational(slot_time, 24)
          end
          break
        end
        if cur_time + Rational(slot_time, 24) < next_reservation["start_time"]
          start_time = DateHelper.berlin_time(cur_time)
          end_time = cur_time + Rational(slot_time, 24)
          calendar[cur_day_key] << {id: SecureRandom.uuid, start: start_time, end: end_time, studio: self.studio_id}
          cur_time += Rational(slot_time, 24)
        else
          cur_time = next_reservation["end_time"]
          r_p += 1
          next_reservation = reservations[r_p]
        end
      end
    end
    return calendar
  end

  def merge_bookings_by_day(intervals)
    return [] if intervals.empty?
    res = []
    booked_time = {start_time: intervals[0].start_time, end_time: intervals[0].end_time}
    for i in 1..intervals.size - 1
      if intervals[i].start_time <= booked_time[:end_time]
        booked_time[:end_time] = DateHelper.max_date(booked_time[:end_time], intervals[i].end_time)
      else
        res << booked_time
        booked_time = {start_time: intervals[i].start_time, end_time: intervals[i].end_time}
      end
    end
    group_by_day(res)
  end

  def group_by_day(events)
    merged = events.reduce({}) do |result, event|
      start_time = event[:start_time]
      end_time = event[:end_time]

      day = DateHelper.to_iso_date_string(start_time)

      if result.key?(day)
        result[day] << { "start_time" => start_time.to_datetime, "end_time" => end_time.to_datetime }
      else
        result[day] = [{ "start_time" => start_time.to_datetime, "end_time" => end_time.to_datetime }]
      end
      result
    end
    merged
  end

end