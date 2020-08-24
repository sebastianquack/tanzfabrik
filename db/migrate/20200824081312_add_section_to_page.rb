class AddSectionToPage < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :section, :string, :default => "stage"  if not column_exists?(:pages, :section)
  end
end
