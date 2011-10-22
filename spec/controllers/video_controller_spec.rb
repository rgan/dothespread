require 'spec_helper'

describe VideosController do

  it "should respond to videos" do
    get :index
    response.status.should == 200
  end

end