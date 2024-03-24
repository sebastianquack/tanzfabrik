source 'https://rubygems.org'
ruby "2.7.8"

gem "bundler"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~>6.0'
gem 'ZenTest'

gem 'pg'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

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
gem 'aws-sdk-s3', '~> 1'

gem "arbre", '~> 1.3'

gem 'groupdate', '>=4' # group by date
gem 'rails-settings-cached' # store instance settings as json column

# translatable columns, translates model attributes
gem 'traco'

gem 'ckeditor_rails'

gem 'meta-tags'
gem 'htmlentities'

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
gem "webpacker", "~> 5.4.4"

# embed svg files
gem 'inline_svg'

gem 'nokogiri', "~> 1.11.0"

group :production do
	gem 'rails_12factor'
  #gem 'heroku_rails_deflate' # enables gzip compression
  gem 'unicorn-rails'
  gem 'unicorn-worker-killer'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem "letter_opener" # for email testing
  gem 'listen' # auto reload on file change
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end
