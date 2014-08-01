class AddProfessionalToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :professional, :boolean, :default => false
  end
end
