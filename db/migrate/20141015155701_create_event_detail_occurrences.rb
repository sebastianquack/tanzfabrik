class CreateEventDetailOccurrences < ActiveRecord::Migration
  def change
    create_table :event_detail_occurrences do |t|
      t.integer :event_id
      t.integer :event_detail_id
      t.datetime :time

      t.timestamps
    end
  end
end
