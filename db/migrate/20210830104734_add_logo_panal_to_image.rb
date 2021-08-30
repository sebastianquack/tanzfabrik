class AddLogoPanalToImage < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :logo_panel, :boolean, :default => false
  end
end
