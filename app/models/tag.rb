class Tag < ActiveRecord::Base
  translates :name, :abbr

  has_many :event_detail_tags
  has_many :event_details, :through => :event_detail_tags
  has_many :events, :through => :event_details

  def short
    return self.abbr if self.abbr
    self.id.to_s
  end

end
