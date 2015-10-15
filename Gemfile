source 'http://rubygems.org'


# Devise
gem 'devise'
source "https://rails-assets.org" do
  gem "rails-assets-angular-devise"
end

gem 'will_paginate'

gem 'mailboxer'

# omniauth
gem 'omniauth'
gem 'omniauth-github'


gem 'daemons'
gem 'delayed_job_active_record'

#front-end
gem "font-awesome-rails"

gem 'paperclip'
# Using Amazon S3 to store images
gem 'aws-sdk', '< 2.0'

gem 'httparty'

gem 'simple_form'

gem 'git-hooks'
gem 'figaro'
gem 'angularjs-rails'
gem 'angular_rails_csrf'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'tzinfo-data'
gem 'tzinfo', '~> 1.2.2'
gem 'puma'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'rvm-capistrano'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails'
  gem 'jasmine'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'guard-rspec'
  gem 'guard-jasmine'
  # gem 'pry' # included in jazz-hands as a dependency
  gem 'jazz_hands',
    github: 'nixme/jazz_hands',
    branch: 'bring-your-own-debugger'
  gem 'better_errors'
  gem 'binding_of_caller'

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'letter_opener'

  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-delayed-job', require: false
  gem 'capistrano3-puma',   require: false
end
