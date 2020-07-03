class AddImagesAndDownloadsToContentModule < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :content_module_id, :integer
    add_column :downloads, :content_module_id, :integer
  end
end
