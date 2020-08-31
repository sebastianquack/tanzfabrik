require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tanzfabrik
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :de
    
    config.serve_static_files = true

    #config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    #config.assets.precompile += ['application_edit.js', 'application_edit.css']

    config.stage_event_types = [1,7,8,9]
    config.event_types_with_page = (1..9).to_s # all event types have pages finally as of relaunch  2020

    config.active_record.belongs_to_required_by_default = false

    config.eager_load_paths += %W(#{config.root}/lib)

    # enter TLDs to remove
    config.domains_to_remove_from_links = [
      "herokuapp.com",
      "tanzfabrik-berlin.de",
      "localhost:3000"
    ]

  end
end
