class AddParameterToContentModule < ActiveRecord::Migration[6.0]
  def change
    add_column :content_modules, :parameter, :string
  end
end
