class AddPageToFestival < ActiveRecord::Migration[6.0]
  def change
    add_column :festivals, :page_id, :integer
  end
end
