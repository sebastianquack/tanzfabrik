class AddFacebookLinks < ActiveRecord::Migration
  def change
    add_column :events, :facebook, :string
    add_column :festivals, :facebook, :string
  end
end
