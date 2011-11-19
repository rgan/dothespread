desc "This task is called by the Heroku cron add-on"
task :generate_map_from_analytics => :environment do
  MapJob.new().perform()
end