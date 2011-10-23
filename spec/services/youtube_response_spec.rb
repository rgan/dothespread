require "spec_helper"

describe YoutubeResponse do

  it "should parse url and token from response" do
    response = "<response><url>http://uploads.gdata.youtube.com/action/FormDataUpload/AEF3087AUD</url><token>AEwbFAQEvf3xox</token></response>"

    response_object = YoutubeResponse.from(response)
    response_object.url.should == 'http://uploads.gdata.youtube.com/action/FormDataUpload/AEF3087AUD'
    response_object.token.should == 'AEwbFAQEvf3xox'
  end
end