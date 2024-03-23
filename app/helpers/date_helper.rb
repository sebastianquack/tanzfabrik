module DateHelper
  def self.max_date date1, date2
    date1 > date2 ? date1 : date2
  end

  def self.to_iso_date_time(date)
    Time.utc(date.year, date.month, date.day, 0, 0, 0).strftime("%Y-%m-%dT%H:%M:%S")
  end

  def self.to_iso_date_string(date)
    Time.utc(date.year, date.month, date.day).strftime("%Y-%m-%d")
  end

  def self.from_iso_datetime_string(datetime_string)
    DateTime.parse(datetime_string)
  end

  def self.berlin_time(datetime)
    datetime.utc.in_time_zone("Europe/Amsterdam")
  end
end