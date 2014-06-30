class AddWelcomeOptionToImage < ActiveRecord::Migration
  def change
    add_column :images, :show_on_welcome_screen, :boolean
    add_column :events, :feature_on_welcome_screen, :boolean
    add_column :festivals, :feature_on_welcome_screen, :boolean
  end
end
