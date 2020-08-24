class AddImageToTextItem < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :text_item_id, :integer if not column_exists?(:images, :text_item_id)
  end
end
