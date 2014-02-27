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

  def datetime format
    dt = DateTime.new(
      self.start_date.year, 
      self.start_date.month, 
      self.start_date.day, 
      self.time.hour, 
      self.time.min, 0, 0)
    return I18n.l(dt, :format => format)
  end

end
