class Image < ActiveRecord::Base  
  has_attached_file :attachment,
    :styles => { 
      :background => "1000x1000>", 
      :large => ["600x600>", :jpg],
      :medium_detail_column => ["330>", :jpg], 
      :people => ['144x150#'],
      :people_hires => ['288x300#', :jpg],
      :medium => ["300x300>", :jpg], 
      :thumb => ["100x100>", :jpg]
      },
    :convert_options => { 
      :background => "-quality 92 -strip",
      :medium_detail_column => "-quality 72",
      :people => "-quality 70", 
      :people_hires => "-quality 70"
      },
    :storage => :s3,
    :bucket         => ENV['S3_TANZFABRIK_BUCKET'],
    :s3_credentials => { :access_key_id     => ENV['S3_KEY'], 
                         :secret_access_key => ENV['S3_SECRET'] },
    :url => ':s3_domain_url',
    :path => "images/:id/:style.:extension"
  
  
  # needs to be declared after has_attached_file !!
  validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/ 
  
  belongs_to :studio
  belongs_to :person
  belongs_to :event
  belongs_to :festival
  belongs_to :page

end
