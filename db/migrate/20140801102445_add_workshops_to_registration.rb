class AddWorkshopsToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :workshop_id_1, :integer, :default => nil
    add_column :registrations, :workshop_id_2, :integer, :default => nil
    add_column :registrations, :workshop_id_3, :integer, :default => nil
    add_column :registrations, :workshop_id_4, :integer, :default => nil
  end
end
