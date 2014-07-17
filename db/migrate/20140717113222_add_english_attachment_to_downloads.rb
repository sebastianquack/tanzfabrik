class AddEnglishAttachmentToDownloads < ActiveRecord::Migration
  def change
    add_attachment :downloads, :attachment_en
  end
end
