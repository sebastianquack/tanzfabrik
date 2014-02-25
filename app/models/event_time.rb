class EventTime < ActiveRecord::Base
  belongs_to :event
  belongs_to :studio

  after_initialize :init

  def init
      self.duration = 60
  end
end
