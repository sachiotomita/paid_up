source "https://rubygems.org"

gem 'rails', '>= 4.2'
gem 'rails-i18n'
gem 'haml-rails'
gem 'jquery-rails'
gem 'uglifier'
gem 'jeweler'
gem 'bootswitch', path: '~/Gems/bootswitch'
gem 'bootstrap_leather'
gem 'seedbank'
gem 'chronic'
gem 'devise'
gem 'cancan'
gem 'stripe'

group :test, :development do
  gem 'rspec-rails'
  gem 'rspec-collection_matchers'
  gem 'database_cleaner'
  gem 'sqlite3'
  gem 'high_voltage'
  gem 'forgery'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'shoulda-matchers'
  gem 'minitest', '~>5.5.1'
  gem "launchy", "~> 2.1.2", require: false
  gem 'factory_girl_rails', require: false
  gem 'coveralls', require: false
  gem 'stripe-ruby-mock', '~> 2.1.1', :require => 'stripe_mock'
end

# Declare your gem's dependencies in paid_up.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'
