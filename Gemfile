# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'
gem 'acts_as_list', '~> 1.0.4'
gem 'bcrypt', '~> 3.1.17'
gem 'bootsnap', require: false
gem 'dry-validation', '~> 1.8.0'
gem 'ffaker', '~> 2.21.0'
gem 'jsonapi-serializer', '~> 2.2.0'
gem 'jwt', '~> 2.3.0'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors', '~> 1.1.1'
gem 'rails', '~> 7.0.2', '>= 7.0.2.3'
gem 'reform', '~> 2.6.1'
gem 'reform-rails', '~> 0.2.3'
gem 'trailblazer-loader', '~> 0.1.2'
gem 'trailblazer-rails', '~> 2.4.0'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'pry', '~> 0.14.1'
  gem 'rspec-rails'
end

group :test do
  gem 'dox', require: false
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'json_matchers', '~> 0.11.1'
  gem 'rexml', '~> 3.2.5'
  gem 'shoulda-matchers', '~> 5.1.0'
end
