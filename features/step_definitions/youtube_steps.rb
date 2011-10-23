Given /^I have an invalid authsub token and key$/ do
  @token = "invalid"
  @key = "invalid"
end

When /^I post video title "([^"]+)"$/ do |title|
  begin
    video = Video.new(title, @token)
    @response = Youtube.postVideoMetadata(video)
  rescue Exception => ex
    @error = ex.message
  end
end

Then /^I should not get back a valid response from youtube$/ do
  @error.include?("Invalid developer key").should be_true
end
