class AddImageAssociations < ActiveRecord::Migration
  def change
    add_column :images, :studio_id, :integer
    add_column :images, :person_id, :integer
    add_column :images, :event_id, :integer
    add_column :images, :festival_id, :integer
  end
end
