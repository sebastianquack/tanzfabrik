class BetterEventTime < ActiveRecord::Migration
  def change
    add_column :event_times, :start_date, :date
    add_column :event_times, :end_date, :date
    add_column :event_times, :time, :time
    remove_column :event_times, :datetime
    add_column :event_times, :repeat_mode_id, :integer
  end
end
