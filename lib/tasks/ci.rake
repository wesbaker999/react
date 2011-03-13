
  desc "REACT CI"
  task :ci => :environment do
    system("cucumber --format junit --out features/reports")
    system("rake react_reporter:send")
  end
