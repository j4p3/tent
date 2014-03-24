require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Tent
  class Application < Rails::Application

    # CORS headers to allow all external requests
    config.action_dispatch.default_headers = {
        'Access-Control-Allow-Origin' => '*',
        'Access-Control-Request-Method' => '*',
        'Access-Control-Allow-Methods' => %w{GET POST PUT DELETE OPTIONS}.join(","),
        'Access-Control-Allow-Headers' => %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")
    }

    config.api_only = true

    config.clients = ActiveSupport::OrderedOptions.new
    facebook_config = YAML.load_file("#{::Rails.root}/config/secrets/facebook.yml")["#{Rails.env}"]

    config.clients.facebook_id = facebook_config["client_id"]
    config.clients.facebook_secret = facebook_config["client_secret"]

    # Explicitly include ActionDispatch test modules
    # config.middleware.use ActionDispatch::TestResponse

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Devise options:
    # Necessary additions for Devise to function without complaining, but not used by application.
    config.middleware.use Rack::Session::Cookie
    # config.middleware.use ActionDispatch::Flash
  end
end
