class AddContentModule < ActiveRecord::Migration
  def change

    create_table :content_modules do |t|
      t.string :module_type
      t.string :test_content
      t.integer :page_id
      t.integer :order
      t.timestamps
    end

  end
end
