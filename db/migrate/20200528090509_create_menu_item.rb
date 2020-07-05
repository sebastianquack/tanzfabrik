class CreateMenuItem < ActiveRecord::Migration[4.2]
  def change
    create_table :menu_items, if_not_exists: true do |t|
      t.string :name_de
      t.string :name_en
      t.string :key
      t.integer :page_id
    end
  end
end
