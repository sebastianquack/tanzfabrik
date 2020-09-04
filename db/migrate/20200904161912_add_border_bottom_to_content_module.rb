class AddBorderBottomToContentModule < ActiveRecord::Migration[6.0]
  def change
    add_column :content_modules, :border_bottom, :string, :default => "m" # ..., s, m, l ... small medium large
  end
end
