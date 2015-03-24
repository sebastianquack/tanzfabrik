class AddChangefreqToPages < ActiveRecord::Migration
  def change
    add_column :pages, :changefreq, :string, :default => "weekly"
  end
end
