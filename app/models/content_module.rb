class ContentModule < ActiveRecord::Base
  
  belongs_to :page

  has_rich_text :rich_content_1_de
  has_rich_text :rich_content_1_en
  
  has_rich_text :rich_content_2_de
  has_rich_text :rich_content_2_en

  translates :super, :headline, :sub, :special_text, :custom_html, :rich_content_1, :rich_content_2, :link_title, :link_href

  has_many :images
  accepts_nested_attributes_for :images, :allow_destroy => true
  
  has_many :downloads
  accepts_nested_attributes_for :downloads, :allow_destroy => true
  
  
  scope :no_draft, -> { where("content_modules.draft = ? OR content_modules.draft IS NULL", false) }

  scope :submenu_dividers, -> { where("module_type = ? ", :submenu_divider) }
  

  def headline_shy
    self.headline.gsub("\\", "&shy;")
  end

end
