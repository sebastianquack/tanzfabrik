class AddPageFestivalIdToDownload < ActiveRecord::Migration
  def change
    add_column :downloads, :page_id, :integer
    add_column :downloads, :festival_id, :integer
  end
end
