require 'rspec/rails'

Capybara.default_driver = :selenium
Cucumber::Rails::World.use_transactional_fixtures = false
Capybara.server do |app, port|
  require 'rack/handler/mongrel'
  Rack::Handler::Mongrel.run(app, :Port => port)
end

Before do
  ActionMailer::Base.clear_cache
end