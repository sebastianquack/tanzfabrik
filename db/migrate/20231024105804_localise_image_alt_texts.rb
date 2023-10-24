class LocaliseImageAltTexts < ActiveRecord::Migration[6.0]
  def change
    rename_column :images, :description, :description_de if not column_exists?(:images, :description_de)
    add_column :images, :description_en, :string if not column_exists?(:images, :description_en)
  end
end
