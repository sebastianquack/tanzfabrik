class AddDanceIntensiveToPeople < ActiveRecord::Migration
  def change
    add_column :people, :dance_intensive, :Boolean
  end
end
