class AddSectionToFestival < ActiveRecord::Migration[6.0]
  def change
    add_column :festivals, :section, :string, :default => "buehne" if not column_exists?(:festivals, :section)
  end
end
