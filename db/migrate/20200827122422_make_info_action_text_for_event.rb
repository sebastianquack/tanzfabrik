class MakeInfoActionTextForEvent < ActiveRecord::Migration[6.0]
  def up
     Event.all.each do |event|
      event.info_rich_de = event.info_de
      event.info_rich_en = event.info_en
      event.save
    end
  end
end
