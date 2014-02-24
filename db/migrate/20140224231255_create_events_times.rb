class CreateEventsTimes < ActiveRecord::Migration
  def change
    create_table :events_times do |t|
      t.integer :event_id
      t.time :time
      t.integer :duration
      t.integer :studio_id

      t.timestamps
    end
  end
end
