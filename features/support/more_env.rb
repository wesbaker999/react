require 'rspec/rails'

Capybara.default_driver = :selenium
Cucumber::Rails::World.use_transactional_fixtures = false
