class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :type_id
      t.string :title
      t.text :description
      t.string :warning
      t.float :price
      t.string :language

      t.timestamps
    end
  end
end
