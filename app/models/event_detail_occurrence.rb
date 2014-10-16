class EventDetailOccurrence < ActiveRecord::Base
  belongs_to :event
  belongs_to :event_detail

  has_many :festivals, :through => :event

  def self.where_festival(festival_id)
    if festival_id
      where("events.id IN (?)", Festival.find(festival_id).events.pluck(:id))      
    else
      where("")
    end
  end

end
