class FestivalEvent < ActiveRecord::Base
  belongs_to :event
  belongs_to :festival

  has_many :event_details, :through => :event
end
