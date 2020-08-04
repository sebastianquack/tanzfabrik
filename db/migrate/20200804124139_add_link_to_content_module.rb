class AddLinkToContentModule < ActiveRecord::Migration[6.0]
  def change
    add_column :content_modules, :link_href_de, :string if not column_exists?(:content_modules, :link_href_de)
    add_column :content_modules, :link_href_en, :string if not column_exists?(:content_modules, :link_href_en)
    add_column :content_modules, :link_title_de, :string if not column_exists?(:content_modules, :link_title_de)
    add_column :content_modules, :link_title_en, :string if not column_exists?(:content_modules, :link_title_en)    
  end
end
