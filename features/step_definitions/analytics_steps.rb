When /^I invoke the analytics feed$/ do
  @locations = GoogleAnalytics.getFeed('51973535', ENV["ANALYTICS_USER"], ENV["ANALYTICS_PWD"])
end

Then /^I should get back locations$/ do
    @locations.size.should > 0
end