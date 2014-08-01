class AddMembershipToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :membership_status, :integer, :default => 0
  end
end
