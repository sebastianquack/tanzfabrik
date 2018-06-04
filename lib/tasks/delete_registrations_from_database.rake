namespace :db do
	task :delete_all_registrations => :environment do
	r = Registration.delete_all
	puts "Deleted #{r} registrations"
	end
end
