desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  MapJob.new().perform()
end