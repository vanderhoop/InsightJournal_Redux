source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.14'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'pg'
gem 'devise'
gem 'twitter-bootstrap-rails'
gem 'bootstrap_helper', '3.2.2.0'
gem 'json'
gem 'geocoder'
gem 'faraday', '~> 0.8.1'
gem 'excon', '~> 0.28.0'

# gem 'treat'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

group :development, :test do
  gem "rspec-rails"
  gem "guard-rspec", :require => false
  gem "capybara"
  gem "database_cleaner"
  gem "capybara-webkit"
  gem 'launchy'
  gem "selenium-webdriver"
  gem "jasmine"
  gem "pry-rails"
  gem "awesome_print"
  gem "faker"
end

group :development do
  gem "annotate"
  gem "quiet_assets"
  gem "binding_of_caller"
  gem "meta_request"
  gem "rails-erd"
  gem "better_errors"
  gem "terminal-notifier-guard"
end

group :assets do
  gem "handlebars_assets"
end

gem "simplecov", :require => false, :group => :test
gem 'shoulda-matchers', :group => :test
