class AddInternalNameToRepeatMode < ActiveRecord::Migration
  def change
    add_column :repeat_modes, :internal_name, :string
  end
end
