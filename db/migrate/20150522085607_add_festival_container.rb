class AddFestivalContainer < ActiveRecord::Migration
  def change
    create_table :festival_containers do |t|
      t.string :name_en
      t.string :name_de
      t.text :description_en
      t.text :description_de
      t.boolean :display, default: false      
      t.timestamps
    end

    create_table :festival_festival_containers do |t|
      t.integer :festival_container_id
      t.integer :festival_id
      t.timestamps
    end

    add_column :images, :festival_container_id, :integer
    
  end
end
