class EventTypeAddIndex < ActiveRecord::Migration
  def change
    add_index :event_types, :name, :unique => true
  end
end
