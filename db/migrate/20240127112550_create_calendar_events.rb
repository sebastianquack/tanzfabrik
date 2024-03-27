class CreateCalendarEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :calendar_events do |t|
      t.references :calendar, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.references :booking, foreign_key: true
      t.string :subject
      t.string :description
      t.string :outlook_id

      t.timestamps
    end
  end
end
