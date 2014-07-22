class Tag < ActiveRecord::Base
  translates :name

  has_many :event_detail_tags
  has_many :event_details, :through => :event_detail_tags
end
