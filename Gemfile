source 'http://rubygems.org'

gem 'rails', '3.0.9'
gem 'mysql'
gem 'unicorn'
gem 'authlogic'
gem 'acts_as_versioned'
gem 'uuidtools'
gem 'htmldiff'
gem 'aws-ses', :require => "aws/ses"
gem 'nokogiri'
gem 'react_reporter', :git => "git://github.com/reactualize/react_reporter.git"

group :development, :test do
  gem 'rspec-rails'
  gem 'cucumber-rails'
  gem 'factory_girl_rails'
end

group :test, :cucumber do
  gem 'rcov'
  gem 'capybara', :git => "git://github.com/jnicklas/capybara.git"
  gem 'database_cleaner'
  gem 'cucumber'
  gem 'spork'
  gem 'launchy'    # So you can do Then show me the page
  gem 'mongrel', '1.2.0.pre2'
end
