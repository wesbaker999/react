require 'rspec/rails'

Before do
  ActionMailer::Base.deliveries.clear
end