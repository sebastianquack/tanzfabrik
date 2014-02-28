include IceCube

class EventDetail < ActiveRecord::Base
  belongs_to :event
  belongs_to :studio
  belongs_to :repeat_mode

  delegate :type, :to => :event, :allow_nil => true

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

  def endtime 
    et = Time.new(
      self.end_date.year, 
      self.end_date.month, 
      self.end_date.day, 
      23, 59, 59, 0)
    return et
  end

  def datetime_l format = :default
    return I18n.l(self.datetime, :format => format)
  end

  def occurrences    
    if eval self.repeat_mode.rule
      schedule = Schedule.from_hash((eval self.repeat_mode.rule), :start_date_override => self.datetime)
    else
      schedule = Schedule.new(self.datetime)
    end
          
    if self.end_date
      return schedule.occurrences(self.endtime)
    else
      return [self.datetime]
    end
  end
  
  def occurrences_with_self
    r = []
    self.occurrences.each do |o|
      r << [o, self]
    end
    return r
  end
    
end
