class AddHideDownloadLinksToPage < ActiveRecord::Migration
  def change
    add_column :pages, :hide_download_links, :boolean
  end
end
