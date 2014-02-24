class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :description
      t.string :license

      t.timestamps
    end
    
    add_attachment :images, :attachment
    
  end  
end
