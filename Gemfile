source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails' # TODO: may no longer be needed; see http://guides.rubyonrails.org/5_1_release_notes.html#jquery-no-longer-a-default-dependency
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'cells-rails'
gem 'devise', '~> 4.4.0'
gem 'draper', '~> 3.0.1'
gem 'font-awesome-sass', '~> 4.7.0'
gem 'gettext_i18n_rails'
gem 'haml'
gem 'normalize-scss'
gem 'pundit'
gem 'responders'
gem 'rails-i18n' # still needed for Rails boilerplate text

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  gem 'badgerbadgerbadger', require: false
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.5.1'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'gettext', require: false
  gem 'ruby_parser', require: false # for finding translations in Haml

  gem 'guard', require: false
  gem 'guard-cucumber', require: false
  gem 'guard-rspec', require: false
  gem 'spring-commands-rspec', require: false
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'launchy'
  gem 'rspec-rails', '~> 3.4'
  gem 'shoulda-matchers'
end
