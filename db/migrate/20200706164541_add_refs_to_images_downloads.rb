class AddRefsToImagesDownloads < ActiveRecord::Migration[6.0]
  def change
    remove_column :images, :content_module_id if column_exists?(:images, :content_module_id)
    remove_column :downloads, :content_module_id if column_exists?(:downloads, :content_module_id)

    add_reference :images, :content_module, index: true
    add_reference :downloads, :content_module, index: true
  end
end
