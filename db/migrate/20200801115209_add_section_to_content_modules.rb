class AddSectionToContentModules < ActiveRecord::Migration[6.0]
  def change
    add_column :content_modules, :section, :string if not column_exists?(:content_modules, :section)
  end
end
