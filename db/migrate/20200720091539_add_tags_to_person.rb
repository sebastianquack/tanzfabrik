class AddTagsToPerson < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :tags, :string
  end
end
