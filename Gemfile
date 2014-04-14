source 'http://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'
gem 'bootstrap-sass', '~> 3.0.0.0.rc2'
# Use postgresql as the database for Active Record
gem 'pg'
#gem 'texticle', require: 'texticle/rails'
gem 'pg_search'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
gem 'simple_form'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Use bycrypt to encode keys and restore on cookies sessions
# Use jquery as the JavaScript library
gem 'i18n', '~> 0.6.9'
gem 'jcrop-rails-v2'
#gem 'protected_attributes'
gem "carrierwave"
gem 'bootstrap-wysihtml5-rails'

if RbConfig::CONFIG["target_os"] =~ /mswin|mingw|cygwin/i
  gem "mini_magick"
else
  gem "rmagick", :require => "RMagick"
end

gem "fog"
gem "unf"

gem 'will_paginate-bootstrap'
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem "debugger", "~> 1.6.5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'
gem 'will_paginate', '~> 3.0'
group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :test do
  gem 'rspec-rails'
  gem 'selenium-webdriver', '2.35.1'
  gem "capybara", "~> 2.2.1"
  gem 'factory_girl_rails', '4.2.1'
  gem "spork-rails" , github: 'sporkrb/spork-rails'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem "wdm", ">=0.1.0" if RbConfig::CONFIG["target_os"] =~ /mswin|mingw|cygwin/i
  gem 'guard-rspec'
  gem 'guard-spork'
  gem "database_cleaner"
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
end

gem 'guard-livereload', group: [:development, :test]# You need to install an extensión on your browser



# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
