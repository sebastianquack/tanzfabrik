class CreateFestivalsEvents < ActiveRecord::Migration
  def change
    create_table :festivals_events do |t|
      t.integer :festival_id
      t.integer :event_id

      t.timestamps
    end
  end
end
