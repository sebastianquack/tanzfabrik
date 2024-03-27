class CreateBookingPermissionRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :booking_permission_requests do |t|
      t.references :user, foreign_key: true
      t.string :status
      t.string :permission_type
      t.text :description

      t.timestamps
    end
  end
end
