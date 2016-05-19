class ChangeTextItemsTypes < ActiveRecord::Migration
  def change
    change_column :text_items, :content_de, :text
    change_column :text_items, :content_en, :text
  end
end
