require 'spec_helper'


describe HomeController do

  it "should respond to index" do
    get :index
    response.status.should == 200
  end

  it "should respond to endorsements" do
    get :endorsements
    response.status.should == 200
  end

end