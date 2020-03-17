class AddUrgentPages < ActiveRecord::Migration
  def change
      add_column :pages, :feature_on_welcome_screen_urgent, :boolean, :default => false
  end
end
