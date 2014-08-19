class CreateTextItems < ActiveRecord::Migration
  def change
    create_table :text_items do |t|
      t.string :name
      t.string :content_de
      t.string :content_en

      t.timestamps
    end
    
    add_index :text_items, :name, :unique => true
    
  end
end
