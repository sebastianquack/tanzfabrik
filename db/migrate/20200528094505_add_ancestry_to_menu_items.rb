class AddAncestryToMenuItems < ActiveRecord::Migration[4.2]
  def change
    add_column :menu_items, :ancestry, :string if not column_exists?(:menu_items, :ancestry)
    add_index :menu_items, :ancestry           if not column_exists?(:menu_items, :ancestry)
  end
end
