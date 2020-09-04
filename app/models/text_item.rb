class TextItem < ActiveRecord::Base
  translates :content
  translates :rich_content

  has_rich_text :rich_content_de
  has_rich_text :rich_content_en

  has_many :images
  accepts_nested_attributes_for :images, :allow_destroy => true

  before_validation :fix_trix

  private def fix_trix
    self.rich_content_de = ModelHelpers.fix_trix self.rich_content_de.to_s
    self.rich_content_en = ModelHelpers.fix_trix self.rich_content_en.to_s
  end   

end
