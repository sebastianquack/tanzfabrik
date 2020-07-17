class AddAnchorToMenuItem < ActiveRecord::Migration[6.0]
  def change
    add_column :menu_items, :anchor, :string
  end
end
