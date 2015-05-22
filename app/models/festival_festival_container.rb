class FestivalFestivalContainer < ActiveRecord::Base
  belongs_to :festival
  belongs_to :festival_container
end
