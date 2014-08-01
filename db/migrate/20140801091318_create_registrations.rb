class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :surname
      t.string :prename
      t.string :street
      t.string :city
      t.string :zip
      t.string :phone
      t.string :email
      t.integer :workshop_info
      t.integer :course_program
      t.integer :event_program
      t.boolean :accept_terms
      t.text :note

      t.timestamps
    end
  end
end
