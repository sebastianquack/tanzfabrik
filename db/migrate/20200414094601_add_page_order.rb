class AddPageOrder < ActiveRecord::Migration
  def change
    add_column :pages, :start_page_order, :integer, :default =>  0
    add_column :pages, :show_in_project_menu, :boolean, :default => false
    add_column :pages, :project_menu_order, :integer, :default =>  0
  end
end