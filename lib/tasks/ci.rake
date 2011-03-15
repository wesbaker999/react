if ["development", "test", "cucumber"].include?(Rails.env)
  require 'cucumber/rake/task'

  desc "Run tests and send reports to REACT"
  task :ci => ["spec", "ci:cucumber", "react_reporter:send"]

  namespace :ci do
    Cucumber::Rake::Task.new({:cucumber => 'db:test:prepare'}) do |t|
      t.fork = true
      t.profile = 'default'
      t.cucumber_opts = %w{--format junit --out features/reports}
    end
  end
end