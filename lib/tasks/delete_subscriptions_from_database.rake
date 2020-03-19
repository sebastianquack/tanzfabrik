namespace :db do
	task :delete_all_subscriptions => :environment do
	r = Subscription.delete_all
	puts "Deleted #{r} subscriptions"
	end
end
