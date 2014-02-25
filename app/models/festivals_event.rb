class FestivalsEvent < ActiveRecord::Base
  belongs_to :event
  belongs_to :festival
end
