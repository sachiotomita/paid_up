# frozen_string_literal: true

source 'https://rubygems.org'

group :test, :development do
  gem 'dotenv-rails', '~> 2.2', require: 'dotenv/rails-now'
end

gem 'haml-rails', '>= 1', '< 2'
gem 'jquery-rails', '~> 4'
gem 'rails', '>= 4', '< 6'
gem 'rails-i18n', '>= 4', '< 6'
gem 'uglifier', '>= 2.7', '< 4'

gem 'bootstrap_leather', '~> 0.9'

gem 'chronic', '~> 0.10'
gem 'money', '~> 6.5'

gem 'cancancan', '>= 1', '< 3'
gem 'devise', '>= 3.4', '< 5'
gem 'rolify', '~> 5'
gem 'stripe', '>= 3.8', '< 4' # 3.4 and 3.5 break caching, because they return a singleton

group :development do
  gem 'bundler', '~> 1'
  gem 'coffeelint', '~> 1.14'
  gem 'juwelier', '~> 2'
  gem 'nokogiri', '>= 1.7', '< 2'
  gem 'pre-commit', '~> 0.32'
  gem 'rubocop', '>= 0.49', '< 1'
  gem 'scss_lint', '>= 0.52.0', '< 1', require: false
  gem 'web-console', '~> 3'
end

group :test, :development do
  gem 'bootstrap-sass', '>= 3.3', '< 4'
  gem 'factory_bot_rails', '>= 4.8', '< 5'
  gem 'forgery', '~> 0.6'
  gem 'rails-controller-testing', '~> 1'
  gem 'rspec-rails', '~> 3'
  gem 'sass-rails', '>= 5', '< 7'
  gem 'sqlite3', '~> 1.3'
end

group :test do
  gem 'capybara', '~> 2'
  gem 'coveralls', '>= 0.8', '< 2', require: false
  gem 'database_cleaner', '~> 1'
  gem 'launchy', '~> 2.4', require: false
  gem 'rspec-collection_matchers', '~> 1.1'
  gem 'shoulda-matchers', '>= 2', '< 4'
end
