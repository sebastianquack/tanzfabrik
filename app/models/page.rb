class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title_de, use: [:slugged, :finders]

  translates :title, :content

  has_many :images
  accepts_nested_attributes_for :images, :allow_destroy => true
  
  has_many :downloads
  accepts_nested_attributes_for :downloads, :allow_destroy => true
  
  
end
