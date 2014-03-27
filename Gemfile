source 'https://rubygems.org'

#KLD Added from tutorial
#ruby-gemset=railstutorial_rails_4_0
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'

# Listing 5.3 - added on 3/24/2014
gem 'rails', '4.0.3' 
#gem 'rails', '4.0.4'
gem 'bootstrap-sass', '2.3.2.0'
gem 'sprockets', '2.11.0'

# Use sqlite3 as the database for Active Record
#gem 'sqlite3'
group :development, :test do
  gem 'sqlite3', '1.3.8'
  gem 'rspec-rails', '2.13.1'
  # Listing 3.34 added on 3/24/2014 for guard-rspec 
  #gem 'guard-rspec', '2.5.0'
end

#KLD Added from tutorial
group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'
end

# Use SCSS for stylesheets
#gem 'sass-rails', '~> 4.0.0'
gem 'sass-rails', '4.0.1'

# Use Uglifier as compressor for JavaScript assets
#gem 'uglifier', '>= 1.3.0'
gem 'uglifier', '2.1.1'

# Use CoffeeScript for .js.coffee assets and views
#gem 'coffee-rails', '~> 4.0.0'
gem 'coffee-rails', '4.0.1'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
#gem 'jquery-rails'
gem 'jquery-rails', '3.0.4'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'
gem 'turbolinks', '1.1.1'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
#gem 'jbuilder', '~> 1.2'
gem 'jbuilder', '1.0.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  #gem 'sdoc', require: false
  gem 'sdoc', '0.3.20', require: false
end

#KLD Added from tutorial - 
#PostgreSQL and statis assets gems in production 
#for deployement to Heroku
group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
