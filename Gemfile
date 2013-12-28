source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.14'
gem 'pg'
gem 'devise'
gem 'twitter-bootstrap-rails'
gem 'bootstrap_helper', '3.2.2.0'
gem 'json'
gem 'geocoder'

# necessary for Net::HTTP requests to work in production
gem 'faraday', '~> 0.8.1'
gem 'excon', '~> 0.28.0'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem "handlebars_assets"
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development, :test do
  gem "rspec-rails"
  gem "guard-rspec", :require => false
  gem "capybara"
  gem "database_cleaner"
  gem "capybara-webkit"
  gem 'launchy'
  gem "selenium-webdriver"
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

group :test do
  gem 'coveralls', require: false
  # gem "simplecov", :require => false
  gem 'shoulda-matchers'
  gem 'rake'
end


