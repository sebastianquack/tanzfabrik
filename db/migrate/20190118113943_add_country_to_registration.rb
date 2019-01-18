class AddCountryToRegistration < ActiveRecord::Migration
  def change
  	add_column :registrations, :country, :string, :default => ""
  end
end
