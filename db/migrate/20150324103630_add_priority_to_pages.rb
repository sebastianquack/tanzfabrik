class AddPriorityToPages < ActiveRecord::Migration
  def change
    add_column :pages, :priority, :float, :default => 0.5
  end
end
