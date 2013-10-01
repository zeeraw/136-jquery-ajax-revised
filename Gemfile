ruby '1.9.3'
source 'https://rubygems.org'

gem 'pry' # best shit ever

gem 'rails', '3.2.14'

gem 'sqlite3'
gem 'haml'


gem 'figaro'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

gem 'jquery-rails'

group :development, :test do

  gem 'rb-fsevent',   :require => false,  group: :darwin
  gem 'spork-rails'
  gem 'rspec-rails'

  gem 'guard'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-bundler'

end

group :test do

  gem 'timecop'
  gem 'factory_girl_rails'
  gem 'database_cleaner'

end
