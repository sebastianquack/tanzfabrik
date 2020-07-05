source 'https://rubygems.org'
ruby "2.5.7"


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~>6.0'
#gem 'ZenTest'

gem 'pg'

# Use SCSS for stylesheets
#gem 'sass-rails', '~> 5.1' --> replaced by sassc-rails
#gem 'sassc-rails'

# Use Uglifier as compressor for JavaScript assets
#gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
#gem 'jquery-rails', "4.2.0"
#gem 'jquery-ui-rails'
#gem "sn-jquery-scrollto-rails"

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
#gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'activeadmin', '~>2.7.0' # max 2.7.0
gem 'devise'

gem 'friendly_id', '~> 5.3'

gem "kt-paperclip", "~> 6.2"
#gem 'aws-sdk', '>= 2.0'
gem 'aws-sdk-s3', '~> 1'

gem "arbre", '~> 1.2.1'


gem "ice_cube" # date recurrance library
gem 'groupdate', '>=4' # group by date

# translatable columns, translates model attributes
gem 'traco'

#gem 'bootstrap-sass', '~> 3.1.1'
#gem 'x-editable-rails', :git => "https://github.com/retani/x-editable-rails.git", :branch => "wysihtml5-encode-html"
#gem 'x-editable-rails', :path => "/Users/holger/Documents/Projekte/tanzfabrik/x-editable-rails"

gem 'ckeditor_rails'

#gem 'bourbon'

gem 'meta-tags'
gem 'htmlentities'

# remove after upgrade to webpacker
gem "parsley-rails"

# allows to modify time and date, to simulate future dates
gem 'timecop' 

# probably: list of coutries for workshop registration
gem "geocoder"

# for search
gem "fuzzy-string-match"
gem "devise-i18n"

gem 'sitemap_generator', '~> 6'
gem 'fog-aws' # for sitemap_generator, also part of paperclip

gem 'countries' # list of countries and translations

# for menu item tree
gem 'ancestry', '~> 3.0.7'
gem "active_admin-sortable_tree", "~> 2.1.0"

# webpack
gem "webpacker", "~> 5.1"

group :production do
	gem 'rails_12factor'
  #gem 'heroku_rails_deflate' # enables gzip compression
  gem 'unicorn-rails'
end

group :development do
  gem "spring"
  gem "letter_opener" # for email testing
  gem 'listen' # auto reload on file change
end
