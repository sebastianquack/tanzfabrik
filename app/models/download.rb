class Download < ActiveRecord::Base

  translates :description

  paperclip_config = {
    :storage => :s3,
    :bucket         => ENV['S3_TANZFABRIK_BUCKET'],
    :s3_credentials => { :access_key_id     => ENV['S3_KEY'], 
                         :secret_access_key => ENV['S3_SECRET'] },
    :url => ':s3_domain_url',
    :path => "downloads/:id/:filename"
  }

  has_attached_file :attachment_de, paperclip_config
  has_attached_file :attachment_en, paperclip_config
  
  # needs to be declared after has_attached_file !!
  validates_attachment_content_type :attachment_de, :content_type => "application/pdf"
  validates_attachment_content_type :attachment_en, :content_type => "application/pdf"
  
  belongs_to :festival
  belongs_to :page

  def attachment
    logger.debug("+++"+self.attachment_en.url )
    if I18n.locale.to_s == "de"
      if self.attachment_de.exists?
        return self.attachment_de
      else
        return self.attachment_en
      end
    else
      if self.attachment_en.exists?
        return self.attachment_en
      else
        return self.attachment_de
      end
    end
  end  
  
end
