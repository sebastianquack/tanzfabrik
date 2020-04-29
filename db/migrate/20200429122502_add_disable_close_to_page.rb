class AddDisableCloseToPage < ActiveRecord::Migration
  def change
    add_column :pages, :disable_close, :boolean, :default => false
  end
end
