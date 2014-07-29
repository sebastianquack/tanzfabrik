class AddAbbrToTags < ActiveRecord::Migration
  def change
    add_column :tags, :abbr_de, :string
    add_column :tags, :abbr_en, :string    
  end
end
