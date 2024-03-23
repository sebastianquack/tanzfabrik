class CreateBookingTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :booking_types do |t|
      t.string :name
      t.string :price_per
      t.string :time

      t.timestamps
    end
  end
end
