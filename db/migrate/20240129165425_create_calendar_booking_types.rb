class CreateCalendarBookingTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :calendar_booking_types do |t|
      t.string :settings
      t.references :calendar, foreign_key: true
      t.references :booking_type, foreign_key: true
      t.timestamps
    end
    add_index :calendar_booking_types, [:calendar_id, :booking_type_id], unique: true
  end
end
