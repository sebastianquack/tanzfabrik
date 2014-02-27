class CreateRepeatModes < ActiveRecord::Migration
  def change
    create_table :repeat_modes do |t|
      t.text :description
      t.text :rule

      t.timestamps
    end
  end
end
