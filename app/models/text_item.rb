class TextItem < ActiveRecord::Base
  translates :content
  translates :rich_content

  has_rich_text :rich_content_de
  has_rich_text :rich_content_en

  has_many :images
  accepts_nested_attributes_for :images, :allow_destroy => true

end
