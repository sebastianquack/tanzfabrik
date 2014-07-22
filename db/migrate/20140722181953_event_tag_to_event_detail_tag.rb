class EventTagToEventDetailTag < ActiveRecord::Migration
  def change
    rename_column :event_tags, :event_id, :event_detail_id
    rename_table :event_tags, :event_detail_tags
  end

def migrate(direction)
    super

    # this code only updates 
    if direction == :up
      EventDetailTag.all.each do |edt| 
        relevant_ed = EventDetail.where(:event_id => edt.event_detail_id).first
        if !relevant_ed.nil?
          edt.event_detail_id = relevant_ed.id
          edt.save
        end
      end
    end
  end

end
