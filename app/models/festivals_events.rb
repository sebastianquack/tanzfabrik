class FestivalsEvents < ActiveRecord::Base
  belongs_to :event
  belongs_to :festival
end
