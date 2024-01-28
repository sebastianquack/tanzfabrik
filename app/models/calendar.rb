class Calendar < ActiveRecord::Base
  belongs_to :studio
  has_many :bookings
  has_many :events, class_name: :CalendarEvent

  def get_availabilities
    now = DateHelper.to_iso_date_string(Date.today)
    to = DateHelper.to_iso_date_string(Date.today >> 2)
    upcoming_events = events.where("start_time >= ? AND end_time <= ?", now, to).order(start_time: :asc)
    merged_bookings_by_day = merge_bookings_by_day(upcoming_events)
    return build_calendar_availabilities(28, merged_bookings_by_day)
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
    merge_by_day(res)
  end

  def merge_by_day(events)
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

  def build_calendar_availabilities(days_forward, reservations_by_day)
    opening_hour = 7
    closing_hour = 17
    slot_time = 2
    
    calendar = {}

    for i in 0..days_forward do
      cur_day = Date.today + i
      cur_day_key = DateHelper.to_iso_date_string(cur_day)
      calendar[cur_day_key] = []
      reservations = reservations_by_day[cur_day_key]

      cur_time = DateTime.new(cur_day.year, cur_day.month, cur_day.day, opening_hour, 0, 0)
      closes_at = DateTime.new(cur_day.year, cur_day.month, cur_day.day, closing_hour, 0, 0)

      if reservations.nil?
        while cur_time + Rational(slot_time, 24) <= closes_at
          calendar[cur_day_key] << DateHelper.berlin_time(cur_time)
          cur_time += Rational(slot_time, 24)
        end
        next
      end

      r_p = 0
      next_reservation = reservations[r_p]

      while cur_time + Rational(slot_time, 24) <= closes_at
        if next_reservation.nil?
          while cur_time + Rational(slot_time, 24) <= closes_at
            calendar[cur_day_key] << DateHelper.berlin_time(cur_time)
            cur_time += Rational(slot_time, 24)
          end
          break
        end
        if cur_time + Rational(slot_time, 24) < next_reservation["start_time"]
          calendar[cur_day_key] << DateHelper.berlin_time(cur_time)
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
end