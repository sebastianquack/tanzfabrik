class CreateMenuItem < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :name_de
      t.string :name_en
      t.string :key
      t.integer :page_id
    end
  end
end
