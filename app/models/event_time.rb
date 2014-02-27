class EventTime < ActiveRecord::Base
  belongs_to :event
  belongs_to :studio

  after_initialize :init

  def init
      self.duration = 60
  end

  def full_location
    self.studio.location.name + " " + self.studio.name
  end

end
