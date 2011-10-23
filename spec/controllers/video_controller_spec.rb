require 'spec_helper'

describe VideosController do

  it "should respond to videos" do
    get :index
    response.status.should == 200
  end

  it "should post video metadata to youtube if valid" do
    video = Video.new("foo", "bar")
    response = YoutubeResponse.new("url", "token")
    Youtube.should_receive(:postVideoMetadata).with(video).and_return(response)
    post :create, :title => "foo", :token => "bar"
    response.should render_template("upload")
  end

  it "should not post video metadata if not valid" do
    post :create, :title => "", :token => "bar"
    Youtube.should_not_receive(:postVideoMetadata)
    response.should render_template("new")
  end

end