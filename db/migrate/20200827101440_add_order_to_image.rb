class AddOrderToImage < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :order, :integer, :default => 0 if not column_exists?(:images, :order)
  end
end
