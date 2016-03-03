class AddFestivalContainerIdToDownload < ActiveRecord::Migration
  def change
    add_column :downloads, :festival_container_id, :integer
  end
end
