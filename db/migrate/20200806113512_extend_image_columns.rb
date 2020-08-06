class ExtendImageColumns < ActiveRecord::Migration[6.0]
  def up
    add_column :images, :super_de, :string         if not column_exists?(:images, :super_de)
    add_column :images, :super_en, :string         if not column_exists?(:images, :super_en)
    add_column :images, :headline_de, :string      if not column_exists?(:images, :headline_de)
    add_column :images, :headline_en, :string      if not column_exists?(:images, :headline_en)
    add_column :images, :link_href_de, :string     if not column_exists?(:images, :link_href_de)
    add_column :images, :link_href_en, :string     if not column_exists?(:images, :link_href_en)
    add_column :images, :link_title_de, :string    if not column_exists?(:images, :link_title_de)
    add_column :images, :link_title_en, :string    if not column_exists?(:images, :link_title_en)    
  end
  def down
    remove_column :images, :super_de, :string         if column_exists?(:images, :super_de)
    remove_column :images, :super_en, :string         if column_exists?(:images, :super_en)
    remove_column :images, :headline_de, :string      if column_exists?(:images, :headline_de)
    remove_column :images, :headline_en, :string      if column_exists?(:images, :headline_en)
    remove_column :images, :link_href_de, :string     if column_exists?(:images, :link_href_de)
    remove_column :images, :link_href_en, :string     if column_exists?(:images, :link_href_en)
    remove_column :images, :link_title_de, :string    if column_exists?(:images, :link_title_de)
    remove_column :images, :link_title_en, :string    if column_exists?(:images, :link_title_en)    
  end  
end
