class AddSequenceToEvent < ActiveRecord::Migration
  def change
    add_column :events, :sequence, :integer, :default => 0
  end
end
