class RenameJoinTables < ActiveRecord::Migration
  def change
    rename_table :festivals_events, :festival_events
    rename_table :persons_events, :person_events
    rename_table :events_times, :event_times
    rename_table :events_tags, :event_tags
  end
end
