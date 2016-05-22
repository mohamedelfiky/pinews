require File.expand_path('../boot', __FILE__)

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
# require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pinews
  class Application < Rails::Application
    config.time_zone = 'Central Time (US & Canada)'

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: false,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       request_specs: false,
                       controller_specs: false
    end
    config.serve_static_files = true

    config.middleware.insert_before 0, 'Rack::Cors' do
      allow do
        origins '*'

        resource '*',
                 headers: :any,
                 methods: %i(get post delete put options head),
                 expose: %w(access-token expiry token-type uid client),
                 max_age: 0
      end
    end
  end
end
