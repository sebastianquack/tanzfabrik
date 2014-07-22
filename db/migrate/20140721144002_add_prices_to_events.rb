class AddPricesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :price_regular, :decimal, :precision => 4, :scale => 0, :default => nil
    add_column :events, :price_reduced, :decimal, :precision => 4, :scale => 0, :default => nil
  end
end
