class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.references :calendar, foreign_key: true
      t.string :booking_number
      t.string :type
      t.timestamps
    end
  end
end
