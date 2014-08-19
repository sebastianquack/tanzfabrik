class AddSlugToFestivals < ActiveRecord::Migration
    def change
      add_column :festivals, :slug, :string
      add_index :festivals, :slug, :unique => true
    end
end