source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.1.4"

gem "pg", "~> 0.21"
gem "puma", "~> 3.7"

gem "jsonapi-rails", github: "jsonapi-rb/jsonapi-rails"

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
end

group :development, :test do
  gem "awesome_print"
  gem "byebug"
  gem "factory_bot_rails"
  gem "pry"
  gem "rspec-rails", "~> 3.7"
end

group :test do
  gem "shoulda-matchers", "~> 3.1"
  gem "simplecov", require: false
end
