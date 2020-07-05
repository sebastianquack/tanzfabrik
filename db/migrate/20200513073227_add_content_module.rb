class AddContentModule < ActiveRecord::Migration[4.2]
  def change

    create_table :content_modules, if_not_exists: true do |t|
      t.string :module_type
      t.string :test_content
      t.integer :page_id
      t.integer :order
      t.timestamps
    end

  end
end
