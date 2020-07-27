class Studio < ActiveRecord::Base
  translates :description, :rich_content

  has_rich_text :rich_content_de
  has_rich_text :rich_content_en
  
  belongs_to :location

  has_many :event_details
  has_many :events, :through => :event_details

  has_many :images
  accepts_nested_attributes_for :images, :allow_destroy => true
  
end
