class UpdateStartAndEndDatesOnEvents < ActiveRecord::Migration
  def up
    Event.find_each do |e| 
      e.start_date_cache = e.start_date
      e.end_date_cache = e.end_date
      e.save
    end
  end
end
