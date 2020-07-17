class ContentModule < ActiveRecord::Base
  
  belongs_to :page

  has_many :images
  accepts_nested_attributes_for :images, :allow_destroy => true
  
  has_many :downloads
  accepts_nested_attributes_for :downloads, :allow_destroy => true
  
  has_rich_text :rich_content_1
  has_rich_text :rich_content_2
  
end
