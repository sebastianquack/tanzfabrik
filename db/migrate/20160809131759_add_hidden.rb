class AddHidden < ActiveRecord::Migration
  def change
    add_column :events, :draft, :boolean
    add_column :festivals, :draft, :boolean
    add_column :pages, :draft, :boolean        
    add_column :people, :draft, :boolean            
  end
end
