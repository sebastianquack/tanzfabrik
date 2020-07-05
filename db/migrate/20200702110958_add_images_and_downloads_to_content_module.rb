class AddImagesAndDownloadsToContentModule < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :content_module_id, :integer if not column_exists?(:images, :content_module_id)
    add_column :downloads, :content_module_id, :integer if not column_exists?(:downloads, :content_module_id)
  end
end
