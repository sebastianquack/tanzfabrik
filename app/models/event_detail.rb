include IceCube

class EventDetail < ActiveRecord::Base
  belongs_to :event
  belongs_to :studio
  belongs_to :repeat_mode

  after_initialize :init

  def init
      self.duration = 60
  end

  def full_location
    self.studio.location.name + " " + self.studio.name
  end

  def datetime
    dt = Time.new(
      self.start_date.year, 
      self.start_date.month, 
      self.start_date.day, 
      self.time.hour, 
      self.time.min, 0, 0)
    return dt
  end

  def datetime_l format = :default
    return I18n.l(self.datetime, :format => format)
  end

  def occurences     
    schedule = Schedule.from_hash((eval self.repeat_mode.rule), :start_date_override => self.datetime)    
    if self.end_date
      return schedule.occurrences(self.end_date)
    else
      return [self.datetime]
    end
  end

end
