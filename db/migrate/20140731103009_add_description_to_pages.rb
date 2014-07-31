class AddDescriptionToPages < ActiveRecord::Migration
  def change
    add_column :pages, :description_de, :string
    add_column :pages, :description_en, :string
  end
end
