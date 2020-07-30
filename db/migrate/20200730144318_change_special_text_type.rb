class ChangeSpecialTextType < ActiveRecord::Migration[6.0]
  def change
    change_column :content_modules, :special_text_en, :text
  end
end
