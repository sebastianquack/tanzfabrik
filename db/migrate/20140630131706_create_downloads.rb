class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.string :description_de
      t.string :description_en      
      t.timestamps
    end
    add_attachment :downloads, :attachment
  end
end
