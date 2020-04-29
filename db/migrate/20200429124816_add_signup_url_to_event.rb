class AddSignupUrlToEvent < ActiveRecord::Migration
  def change
    add_column :events, :signup_url, :string
  end
end
