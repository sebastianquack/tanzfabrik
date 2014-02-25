class EventTimeDate < ActiveRecord::Migration
  def change
    remove_column :event_times, :time
    add_column :event_times, :datetime, :datetime
  end
end
