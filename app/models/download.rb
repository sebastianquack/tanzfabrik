class Download < ActiveRecord::Base

  translates :description

  paperclip_config = {
    :path => "downloads/:id/:filename"
  }

  has_attached_file :attachment_de, paperclip_config
  has_attached_file :attachment_en, paperclip_config
  
  # needs to be declared after has_attached_file !!
  validates_attachment_content_type :attachment_de, :content_type => ["application/pdf", "application/zip"]
  validates_attachment_content_type :attachment_en, :content_type => ["application/pdf", "application/zip"]
  
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
