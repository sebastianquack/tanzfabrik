class AddDraftToContentModules < ActiveRecord::Migration[6.0]
  def change
    add_column :content_modules, :draft, :boolean     if not column_exists?(:content_modules, :draft)
    add_column :content_modules, :custom_html, :text  if not column_exists?(:content_modules, :custom_html)
  end
end
