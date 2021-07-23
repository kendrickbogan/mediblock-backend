# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"

gem "dotenv-rails"

gem "activerecord-postgres_enum"
gem "active_storage_base64"
gem "administrate"
gem "aws-sdk-s3", require: false
gem "bootsnap", ">= 1.4.4", require: false
gem "city-state"
gem "clearance", ">= 2.3.1"
gem "graphql", ">= 1.12.5"
gem "httparty"
gem "image_processing"
gem "jbuilder", "~> 2.7"
gem "mimemagic", ">= 0.3.6"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.3"
gem "rubocop", "1.12"
gem "rubyzip"
gem "sass-rails", ">= 6"
gem "sidekiq"
gem "time_for_a_boolean"
gem "turbolinks", "~> 5"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "webpacker", "~> 5.0"
gem "wicked_pdf"
gem "wkhtmltopdf-binary"

group :development, :test do
  gem "capybara"
  gem "factory_bot_rails"
  gem "graphiql-rails"
  gem "pry-rails"
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "webdrivers"
end

group :development do
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "solargraph"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end
