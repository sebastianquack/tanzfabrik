class ChangeEventInfoType < ActiveRecord::Migration
  def change
    change_column :events, :info_de, :text
    change_column :events, :info_en, :text
  end
end
