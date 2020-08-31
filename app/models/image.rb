class Image < ActiveRecord::Base  
  include ModelHelpers

  has_attached_file :attachment,
    :styles => { 
      :background => "1000x1000>", 
      :large => ["600x600>"],
      :medium_detail_column => ["330>"], 
      :people => ['150x195#'],
      :people_hires => ['300x390#'],
      :medium => ["300x300>"], 
      :thumb => ["100x100>"]
      },
    :convert_options => { 
      :background => "-quality 92 -strip",
      :medium_detail_column => "-quality 72",
      :people => "-quality 70", 
      :people_hires => "-quality 70"
      },
    :path => "images/:id/:style.:extension"
  
  
  # needs to be declared after has_attached_file !!
  validates_attachment_content_type :attachment,
  :content_type => ['image/jpeg', 'image/pjpeg',
    'image/jpg', 'image/png', 'image/gif'], :message => "Erlaubte Bildformate: JPG, GIF, PNG."

  #validates_presence_of :description

  before_validation :clean_link

  private def clean_link
    self.link_href_en = ModelHelpers.strip_domain_from_link self.link_href_en.to_s
    self.link_href_de = ModelHelpers.strip_domain_from_link self.link_href_de.to_s
  end

  has_rich_text :rich_content_1_de
  has_rich_text :rich_content_1_en

  translates :super, :headline, :rich_content_1, :link_title, :link_href

  belongs_to :studio
  belongs_to :person
  belongs_to :event
  belongs_to :festival
  belongs_to :page
  belongs_to :festival_container
  belongs_to :content_module
  belongs_to :text_item

end
