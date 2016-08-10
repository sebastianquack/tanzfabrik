class AddFeatureOnWelcomeScreenToPage < ActiveRecord::Migration
  def change
    add_column :pages, :feature_on_welcome_screen, :boolean
    add_column :pages, :feature_on_welcome_screen_note_en, :string
    add_column :pages, :feature_on_welcome_screen_note_de, :string
  end
end
