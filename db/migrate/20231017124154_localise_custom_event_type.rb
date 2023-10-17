class LocaliseCustomEventType < ActiveRecord::Migration[6.0]
  def change
    rename_column :events, :custom_type, :custom_type_de if not column_exists?(:events, :custom_type_de)
    add_column :events, :custom_type_en, :string if not column_exists?(:events, :custom_type_en)
  end
end
