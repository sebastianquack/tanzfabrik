class AddDimensionsToImage < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :width, :integer
    add_column :images, :height, :integer
  end
end
