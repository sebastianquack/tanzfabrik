class AddNewslettersToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :newsletter_1, :boolean, :default => false
    add_column :subscriptions, :newsletter_2, :boolean, :default => false
    add_column :subscriptions, :newsletter_3, :boolean, :default => false
  end
end
