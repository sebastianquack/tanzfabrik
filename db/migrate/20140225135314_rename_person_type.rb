class RenamePersonType < ActiveRecord::Migration
  def change
    rename_column :people, :typ, :role
  end
end
