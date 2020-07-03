class AddBasicAttributesToContentModule < ActiveRecord::Migration[5.2]
  def change
    remove_column :content_modules, :test_content
    add_column :content_modules, :style_option, :string
    add_column :content_modules, :super, :string
    add_column :content_modules, :headline, :string
    add_column :content_modules, :sub, :string
    add_column :content_modules, :main_text, :text
    add_column :content_modules, :main_text_col2, :text 
    add_column :content_modules, :special_text, :text
  end
end