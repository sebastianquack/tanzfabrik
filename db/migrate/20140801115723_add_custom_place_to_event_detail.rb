class AddCustomPlaceToEventDetail < ActiveRecord::Migration
  def change
    add_column :event_details, :custom_place, :string
  end
end
