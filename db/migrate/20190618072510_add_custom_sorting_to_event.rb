class AddCustomSortingToEvent < ActiveRecord::Migration
  def change
    add_column :events, :custom_sorting, :boolean, :default => false
  end
end
