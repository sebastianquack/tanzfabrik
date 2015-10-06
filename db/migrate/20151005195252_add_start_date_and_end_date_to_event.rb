class AddStartDateAndEndDateToEvent < ActiveRecord::Migration
  def change
    add_column :events, :start_date_cache, :date
    add_column :events, :end_date_cache, :date    
  end
end
