class CreateStudios < ActiveRecord::Migration
  def change
    create_table :studios do |t|
      t.string :name
      t.text :description
      t.belongs_to :location
      t.boolean :rentable

      t.timestamps
    end
  end
end
