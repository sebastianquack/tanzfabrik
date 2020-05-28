class AddPositionToMenuItem < ActiveRecord::Migration
  def change
    add_column :menu_items, :position, :integer, :default =>  0
  end
end
