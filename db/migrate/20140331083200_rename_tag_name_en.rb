class RenameTagNameEn < ActiveRecord::Migration
  def change
    rename_column :tags, :name_ed, :name_en
  end
end
