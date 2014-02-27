class RenameEventTime < ActiveRecord::Migration
  def change
    rename_table :event_times, :event_details
  end
end
