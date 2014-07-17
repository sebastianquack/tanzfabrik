class RenameAttachment < ActiveRecord::Migration
  def change
    rename_column :downloads, :attachment_file_name, :attachment_de_file_name
    rename_column :downloads, :attachment_content_type, :attachment_de_content_type
    rename_column :downloads, :attachment_file_size, :attachment_de_file_size
    rename_column :downloads, :attachment_updated_at, :attachment_de_updated_at
  end
end
