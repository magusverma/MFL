source 'https://rubygems.org'
ruby '2.1.4'
gem 'rails', '4.1.7'
group :development, :test do
    gem 'sqlite3'
end

group :production do
    # gem 'pg'
    gem 'rails_12factor'
end

# gem 'sqlite3'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'bootstrap-sass'
gem 'figaro', '>= 1.0.0.rc1'
gem 'high_voltage'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'pundit'
gem 'simple_form'
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
gem 'rails-timeago', '~> 2.0'
gem 'roadie-rails'
gem 'roadie'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_21]
  gem 'capistrano', '~> 3.0.1'
  gem 'capistrano-bundler'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-rails-console'
  gem 'capistrano-rvm', '~> 0.1.1'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
end
