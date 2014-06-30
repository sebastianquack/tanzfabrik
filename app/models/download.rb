class Download < ActiveRecord::Base

  translates :description

  has_attached_file :attachment,
    :storage => :s3,
    :bucket         => ENV['S3_TANZFABRIK_BUCKET'],
    :s3_credentials => { :access_key_id     => ENV['S3_KEY'], 
                         :secret_access_key => ENV['S3_SECRET'] },
    :url => ':s3_domain_url',
    :path => "downloads/:id/:filename"
  
  # needs to be declared after has_attached_file !!
  validates_attachment_content_type :attachment, :content_type => "application/pdf"
  
  belongs_to :festival
  belongs_to :page
  
end
