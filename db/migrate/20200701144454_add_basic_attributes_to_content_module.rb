class AddBasicAttributesToContentModule < ActiveRecord::Migration[5.2]
  def change
    remove_column :content_modules, :test_content       if column_exists?(:content_modules, :test_content)
    add_column :content_modules, :style_option, :string if not column_exists?(:content_modules, :style_option)
    add_column :content_modules, :super, :string        if not column_exists?(:content_modules, :super)
    add_column :content_modules, :headline, :string     if not column_exists?(:content_modules, :headline)
    add_column :content_modules, :sub, :string          if not column_exists?(:content_modules, :sub)
    add_column :content_modules, :main_text, :text      if not column_exists?(:content_modules, :main_text)
    add_column :content_modules, :main_text_col2, :text if not column_exists?(:content_modules, :main_text_col2)
    add_column :content_modules, :special_text, :text   if not column_exists?(:content_modules, :special_text)
  end
end