class Image < ActiveRecord::Base  
  has_attached_file :attachment,
    :styles => { 
      :background => "1000x1000>", 
      :large => ["600x600>"],
      :medium_detail_column => ["330>"], 
      :people => ['144x150#'],
      :people_hires => ['288x300#'],
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

  validates_presence_of :description

  belongs_to :studio
  belongs_to :person
  belongs_to :event
  belongs_to :festival
  belongs_to :page
  belongs_to :festival_container
  belongs_to :content_module

end
