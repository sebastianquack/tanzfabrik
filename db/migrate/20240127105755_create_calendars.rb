class CreateCalendars < ActiveRecord::Migration[6.0]
  def change
    create_table :calendars do |t|
      t.string :name
      t.string :outlook_id
      t.references :studio, foreign_key: true
      t.string :schedule
    end
  end
end
