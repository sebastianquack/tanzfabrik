class ContentModule < ActiveRecord::Base
  include ModelHelpers

  belongs_to :page

  has_rich_text :rich_content_1_de
  has_rich_text :rich_content_1_en
  
  has_rich_text :rich_content_2_de
  has_rich_text :rich_content_2_en

  translates :super, :headline, :sub, :special_text, :custom_html, :rich_content_1, :rich_content_2, :link_title, :link_href

  has_many :images, -> { order(:order) }
  accepts_nested_attributes_for :images, :allow_destroy => true
  
  has_many :downloads
  accepts_nested_attributes_for :downloads, :allow_destroy => true

  validate :border_bottom_is_valid

  private def border_bottom_is_valid
    border_types = Rails.configuration.module_border_bottom_types
    errors.add(:border_bottom, "must be one of: " + border_types.join(", ")) unless
       border_types.include? border_bottom
  end 

  before_validation :clean_link, :fix_trix

  private def clean_link
    self.link_href_en = ModelHelpers.strip_domain_from_link self.link_href_en.to_s
    self.link_href_de = ModelHelpers.strip_domain_from_link self.link_href_de.to_s
  end

  private def fix_trix
    self.rich_content_1_de = ModelHelpers.fix_trix self.rich_content_1_de.to_s
    self.rich_content_1_en = ModelHelpers.fix_trix self.rich_content_1_en.to_s
    self.rich_content_2_de = ModelHelpers.fix_trix self.rich_content_2_de.to_s
    self.rich_content_2_en = ModelHelpers.fix_trix self.rich_content_2_en.to_s
  end  
  
  scope :no_draft, -> { where("content_modules.draft = ? OR content_modules.draft IS NULL", false) }

  scope :submenu_dividers, -> { where("module_type = ? ", :submenu_divider) }
  

  def headline_shy
    self.headline.gsub("\\", "&shy;")
  end

  def process_rich_text rtxt
    rtxt.to_s.gsub(/<h4>↪ /, "<h4>↪" + [160].pack('U*')).html_safe # 160 is the ASCII character code of a non-breaking space
  end

  def rich_content_1_processed
    process_rich_text self.rich_content_1
  end

  def rich_content_2_processed
    process_rich_text self.rich_content_2
  end

end
