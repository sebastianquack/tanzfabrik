class Studio < ActiveRecord::Base
  translates :description, :rich_content

  has_rich_text :rich_content_de
  has_rich_text :rich_content_en
  
  belongs_to :location
  has_one :calendar

  has_many :event_details
  has_many :events, :through => :event_details

  has_many :images
  accepts_nested_attributes_for :images, :allow_destroy => true

  before_validation :fix_trix

  private def fix_trix
    self.rich_content_de = ModelHelpers.fix_trix self.rich_content_de.to_s
    self.rich_content_en = ModelHelpers.fix_trix self.rich_content_en.to_s
  end   

  def fullname
    self.location.name.to_s + " " + self.name.to_s
  end

  scope :by_fullname, ->  { joins(:location).order('locations.name ASC, studios.name ASC') }
  
end
