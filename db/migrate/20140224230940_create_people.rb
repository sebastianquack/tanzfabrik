class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.text :bio
      t.string :typ

      t.timestamps
    end
  end
end
