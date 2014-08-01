class AddCustomTypeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :custom_type, :string
  end
end
