require 'spec_helper'

describe VideosController do

  it "should respond to videos" do
    get :index
    response.status.should == 200
  end

  it "should post video metadata to youtube if valid" do
    video = Video.new("foo", "bar", "keywords")
    response = YoutubeResponse.new("url", "token")
    Youtube.should_receive(:postVideoMetadata).with(video).and_return(response)
    post :create, :video_form => {:title => "foo", :token => "bar", :keywords => "keywords"}
    response.should render_template("upload")
  end

  it "should not post video metadata if not valid" do
    post :create, :video_form => {:title => "", :token => "bar", :keywords => "keywords"}
    Youtube.should_not_receive(:postVideoMetadata)
    response.should render_template("new")
  end

  it "should render respond to uploaded" do
    get :uploaded, :id => "foo"
    response.should render_template("uploaded")
  end

end