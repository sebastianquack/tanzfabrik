class AddPositionToMenuItem < ActiveRecord::Migration[4.2]
  def change
    add_column :menu_items, :position, :integer, :default =>  0 if not column_exists?(:menu_items, :position)
  end
end
