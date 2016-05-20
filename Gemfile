source 'https://rubygems.org'

gem 'rails', '4.2.5'

gem 'rails-api'

group :development do
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'rubocop', require: false
  gem 'guard-rubocop'
end

gem 'mysql2'
gem 'devise'
gem 'devise_token_auth'
gem 'omniauth'
gem 'cancancan', '~> 1.10'
gem 'paperclip', '~> 5.0.0.beta1'

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails', require: false
  # Cleane database in tests
  gem 'database_cleaner'

  # Reporting test coverage to Code Climate
  gem 'simplecov', require: false
  gem 'codeclimate-test-reporter', require: nil

  # Rspec one-liners
  gem 'shoulda-matchers', '~> 3.1'
end

group :test, :development do
  gem 'spring'
  gem 'byebug'
end

gem 'faker'
gem 'jbuilder'
gem 'will_paginate', '~> 3.0.6'
gem 'rack-cors', require: 'rack/cors'
