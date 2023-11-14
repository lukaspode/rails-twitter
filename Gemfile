# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

gem 'rails', '~> 7.1.2'

gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'devise', '~> 4.9', '>= 4.9.3'
gem 'faker', '~> 3.2', '>= 3.2.2'
gem 'importmap-rails'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'redis', '>= 4.0.1'
gem 'rubocop', '~> 1.57', '>= 1.57.2', require: false
gem 'rubocop-rails', '~> 2.22', '>= 2.22.1', require: false
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'dotenv-rails', '~> 2.8', '>= 2.8.1'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.3'
end

group :development do
  gem 'letter_opener', '~> 1.8', '>= 1.8.1'
  gem 'web-console'
end

group :test do
  gem 'shoulda-matchers', '~> 5.3'
end
