class AddNoSignUpWorkshopOption < ActiveRecord::Migration
  def change
      add_column :events, :no_sign_up, :boolean, :default => false
  end
end
