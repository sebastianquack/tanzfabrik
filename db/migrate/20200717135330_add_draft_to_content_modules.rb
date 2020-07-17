class AddDraftToContentModules < ActiveRecord::Migration[6.0]
  def change
    add_column :content_modules, :draft, :boolean
    add_column :content_modules, :custom_html, :text
  end
end
