class AddInfoToEvent < ActiveRecord::Migration
  def change
    add_column :events, :info_de, :string
    add_column :events, :info_en, :string
  end
end
