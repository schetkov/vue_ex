source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails', '6.1.4'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'redis', '~> 4.0'
gem 'bcrypt', '~> 3.1.7'
gem 'jwt_sessions', '~> 2'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'rack-cors'

group :development, :test do
  gem 'pry-byebug', '~> 3.4'
  gem 'pry-rails', '~> 0.3.4'
  gem 'rspec-rails'
  gem 'factory_bot_rails', '~> 4.8'
  gem 'rubocop'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end