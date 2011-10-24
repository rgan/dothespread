Given /^I have an invalid authsub token and key$/ do
  @token = "invalid"
  @key = "invalid"
end

When /^I post video title "([^"]+)" and keywords "([^"]+)"$/ do |title, keywords|
  begin
    video = Video.new(title, @token, keywords)
    @response = Youtube.postVideoMetadata(video)
  rescue Exception => ex
    puts ex.message
    @error = ex.message
  end
end

Then /^I should not get back a valid response from youtube$/ do
  @error.include?("Invalid developer key").should be_true
end
