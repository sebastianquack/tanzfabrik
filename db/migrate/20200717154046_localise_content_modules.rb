class LocaliseContentModules < ActiveRecord::Migration[6.0]
  def change

    rename_column :content_modules, :super, :super_de
    add_column :content_modules, :super_en, :string

    rename_column :content_modules, :headline, :headline_de
    add_column :content_modules, :headline_en, :string

    rename_column :content_modules, :sub, :sub_de
    add_column :content_modules, :sub_en, :string

    rename_column :content_modules, :special_text, :special_text_de
    add_column :content_modules, :special_text_en, :string

    rename_column :content_modules, :custom_html, :custom_html_de
    add_column :content_modules, :custom_html_en, :text

    remove_column :content_modules, :main_text
    remove_column :content_modules, :main_text_col2

  end
end
