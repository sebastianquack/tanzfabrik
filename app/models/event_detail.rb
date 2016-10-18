include IceCube

class EventDetail < ActiveRecord::Base
  belongs_to :event
  belongs_to :studio
  belongs_to :repeat_mode

  has_many :event_detail_tags
  #accepts_nested_attributes_for :event_tags, :allow_destroy => true  

  has_many :tags, :through => :event_detail_tags
  accepts_nested_attributes_for :tags, :allow_destroy => true

  delegate :type, :to => :event, :allow_nil => true

  validates :start_date, presence: true
  validates :end_date, presence: true

  after_initialize :init

  def init
      self.duration = 60 if !self.duration
      if !self.end_date
        self.end_date = self.start_date
      end
  end

  def full_location
    self.studio.location.name + " " + self.studio.name
  end

  def starttime
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

  def endtime_clock
    et = starttime + self.duration.minutes
    return et
  end

  def datetime_l format = :default
    return I18n.l(self.starttime, :format => format)
  end

  def schedule
    unless defined? @schedule_cash
      if eval self.repeat_mode.rule
        new_schedule = Schedule.from_hash((eval self.repeat_mode.rule), :start_date_override => self.starttime)
      else
        new_schedule = Schedule.new(self.starttime)
      end
      @schedule_cash = new_schedule
    end
    return @schedule_cash
  end
    
  def occurrences    
    schedule = self.schedule
    
    unless self.start_date 
      return []
    end
          
    if self.end_date
      return schedule.occurrences(self.endtime)
    else
      return [self.starttime]
    end
  end
  
  def occurrences_with_detail_reference_between start_date, end_date 
    occurrences = self.occurrences_between start_date, end_date
    occurrences_with_event_reference = []
    occurrences.each do |oc| 
      occurrences_with_event_reference.push [oc, self] #create list with [[occurrence, event_detail][occurrence, event_detail]]
    end
    return occurrences_with_event_reference
  end
      
  def occurrences_between start_date, end_date
    schedule = self.schedule    
    end_time = Time.new(end_date.year, end_date.month, end_date.day, 23, 59, 59, 0)
    start_time = Time.new(start_date.year, start_date.month, start_date.day, 0, 0, 0, 0)
    
    logger.debug end_time
    
    o = []
    
    if schedule.occurs_between? start_time, self.endtime
      
      all_occurrences = schedule.occurrences(self.endtime)      
      all_occurrences.each do |occurrence|
        if occurrence >= start_time
          if occurrence <= end_time
            o.push occurrence
          else
            break
          end
        end
      end 
      
    end
      
    return o
    
  end

  def occurs_between? start_date, end_date
    start_time = Time.new(start_date.year, start_date.month, start_date.day, 0, 0, 0, 0)
    
    if start_time > self.endtime
      return false
    else
      schedule = self.schedule    
      return schedule.occurs_between? start_time, self.endtime
    end
  end

  def occurs_on_weekday_between? start_date, end_date
    days = (start_date..end_date).to_a.select {|d| d.wday == start_date.wday}
    days.each do |day|
      if self.occurs_on? day
        return true
      end
    end
    return false
  end  

    
  def occurs_on? date
    if !self.end_date
      return date == self.start_date
    end
        
    if date >= self.starttime.midnight && date <= self.endtime
      return self.schedule.occurs_on? date
    else
      return false
    end
  end

  # when start_date==end_date and empty repeat rule, extend the end_date to 1 year in the future
  def extend_empty_end_date
    if self.end_date == self.start_date && !self.repeat_mode.rule.empty?
      self.end_date = Date.today + 10.year
    end
    return self
  end

  def single_occurrence?
    self.repeat_mode.rule.empty?
  end

  # deletes all EventDetailOccurrences associated with this EventDetail, recalculates and saves them
  def reset_occurrences
    logger.debug "resetting occurrences on event_detail " + self.id.to_s
    
    EventDetailOccurrence.where(:event_detail_id => self.id).delete_all
    
    self.occurrences.each do |oc|
      logger.debug(oc)
      edo = EventDetailOccurrence.new
      edo.event_id = self.event.id
      edo.event_detail_id = self.id
      logger.debug
      edo.time = 
      # get date from occurrence
      # get time from event_detail
        Time.new(oc.year, oc.month, oc.day, self.time.hour, self.time.min, self.time.sec, 0)
      edo.save
    end
  end
    
  def first_event_detail_occurrence
    return EventDetailOccurrence.where(:event_detail_id => self.id).order("time").first
  end
  
  def self.where_festival(festival_id)
    if festival_id
      where("events.id IN (?)", Festival.find(festival_id).events.pluck(:id))      
    else
      where("")
    end
  end
      
end
