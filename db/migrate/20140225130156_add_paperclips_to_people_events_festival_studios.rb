class AddPaperclipsToPeopleEventsFestivalStudios < ActiveRecord::Migration
  def change
    add_attachment :people, :image
    add_attachment :events, :image
    add_attachment :festivals, :image
    add_attachment :studios, :image
  end
end
