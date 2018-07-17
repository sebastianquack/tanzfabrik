heroku pg:copy tanzfabrik::DATABASE_URL NAVY --app tanzfabrik-59 --confirm tanzfabrik-59
heroku run rake db:delete_all_registrations --app tanzfabrik-59