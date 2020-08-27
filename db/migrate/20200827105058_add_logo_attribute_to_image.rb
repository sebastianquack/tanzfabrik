class AddLogoAttributeToImage < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :logo, :boolean, :default => false
  end
end
