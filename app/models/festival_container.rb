class FestivalContainer < ActiveRecord::Base
  translates :name, fallback: :any
  translates :description, fallback: :any

  has_many :festival_festival_containers
  has_many :festivals, :through => :festival_festival_containers

  has_many :images
  accepts_nested_attributes_for :images, :allow_destroy => true

end
