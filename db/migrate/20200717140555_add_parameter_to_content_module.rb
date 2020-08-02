class AddParameterToContentModule < ActiveRecord::Migration[6.0]
  def change
    add_column :content_modules, :parameter, :string if not column_exists?(:content_modules, :parameter)
  end
end
