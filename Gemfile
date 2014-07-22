source 'https://rubygems.org'

gem 'rails', '4.0.4'
gem 'pg'
gem 'sass-rails', '>= 3.2'
gem 'bootstrap-sass', '~> 3.0.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

gem 'jquery-rails'
gem 'sprockets', '2.11.0'
gem 'bcrypt-ruby', '3.1.2'
gem 'simple_form'
gem 'kaminari'
gem 'carrierwave'
gem 'jcrop-rails-v2'
gem 'i18n'
gem 'rails-i18n'
gem 'cancancan', '~> 1.8'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem "bootstrap-wysihtml5-rails"

if RbConfig::CONFIG["target_os"] =~ /mswin|mingw|cygwin/i
  gem "mini_magick"
else
  gem "rmagick", :require => "RMagick"
end

group :production do
	gem 'fog'
	gem 'unf'
	gem 'thin'
	gem 'rails_12factor'
end

group :development, :test do
	gem 'rspec-rails'
	gem "capybara"
	gem 'factory_girl_rails'
	gem "database_cleaner"
end

gem 'sdoc', require: false, group: :doc