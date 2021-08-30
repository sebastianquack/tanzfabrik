class Image < ActiveRecord::Base  
  include ModelHelpers

  has_attached_file :attachment,
    :styles => { 
      :background => "1500x1500>", 
      :large => ["1000x1000>"],
      :medium_detail_column => ["330>"], 
      :people => ['150x195#'],
      :people_hires => ['300x390#'],
      :medium => ["450x450>"], 
      :thumb => ["100x100>"],
      :logo => ["300x300>"],
      :logo_panel => ["900x300>"],
      },
    :convert_options => { 
      :background => "-quality 90 -strip",
      :large => "-quality 85 -strip",
      :medium_detail_column => "-quality 72",
      :people => "-quality 80", 
      :people_hires => "-quality 80",
      :medium  => "-quality 85",
      :logo  => "-quality 90",
      :logo_panel  => "-quality 90 -strip",
      },
    :path => "images/:id/:style.:extension"
  
  
  # needs to be declared after has_attached_file !!
  validates_attachment_content_type :attachment,
  :content_type => ['image/jpeg', 'image/pjpeg',
    'image/jpg', 'image/png', 'image/gif'], :message => "Erlaubte Bildformate: JPG, GIF, PNG."

  #validates_presence_of :description

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

  before_validation :clean_link, :fix_trix
  before_save  :extract_dimensions 


  private def fix_trix
    self.rich_content_1_de = ModelHelpers.fix_trix self.rich_content_1_de.to_s
    self.rich_content_1_en = ModelHelpers.fix_trix self.rich_content_1_en.to_s
  end   

  private def clean_link
    self.link_href_en = ModelHelpers.strip_domain_from_link self.link_href_en.to_s
    self.link_href_de = ModelHelpers.strip_domain_from_link self.link_href_de.to_s
  end  

  private def extract_dimensions
    if attachment.queued_for_write[:original] == nil 
      return
    end
    geometry = Paperclip::Geometry.from_file(attachment.queued_for_write[:original].path)
    #return unless geometry
    puts "XXX"
    puts geometry.inspect
    puts geometry.horizontal?
    puts geometry.width
    puts geometry.width.to_i
    self.width = geometry.width.to_i
    self.height = geometry.height.to_i
  end

end
