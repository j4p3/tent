require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module TentApi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    # Only use API modules
    config.api_only = true

    # CORS headers to allow all external requests
    config.action_dispatch.default_headers = {
        'Access-Control-Allow-Origin' => '*',
        'Access-Control-Request-Method' => '*',
        'Access-Control-Allow-Methods' => %w{GET POST PUT DELETE OPTIONS}.join(","),
        'Access-Control-Allow-Headers' => %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")
    }

    config.clients = ActiveSupport::OrderedOptions.new
    config_secrets = YAML.load_file("#{::Rails.root}/config/secrets.yml")
    facebook_config = {
      client_id: ENV["FACEBOOK_ID_#{Rails.env}"] || config_secrets["facebook"]["#{Rails.env}"]["client_id"],
      client_secret: ENV["FACEBOOK_SECRET_#{Rails.env}"] || config_secrets["facebook"]["#{Rails.env}"]["client_secret"]
    }

    firebase_config = {
        repo: ENV["FIREBASE_REPO_#{Rails.env}"] || config_secrets["firebase"]["#{Rails.env}"]["repo"],
        root: ENV["FIREBASE_ROOT_#{Rails.env}"] || config_secrets["firebase"]["#{Rails.env}"]["root"]
    }

    config.clients.facebook_id = facebook_config[:client_id]
    config.clients.facebook_secret = facebook_config[:client_secret]
    config.clients.firebase_repo = firebase_config[:repo]
    config.clients.firebase_root = firebase_config[:root]

    # Explicitly include ActionDispatch test modules
    # config.middleware.use ActionDispatch::TestResponse

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # required for Omniauth?
    config.middleware.use Rack::Session::Cookie
  end
end
