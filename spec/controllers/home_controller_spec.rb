require 'spec_helper'


describe HomeController do

  it "should respond to index" do
    get :index
    response.status.should == 200
    response.should render_template("index")
  end

  it "should respond to endorsements" do
    get :endorsements
    response.status.should == 200
  end

  it "should use mobile format when user-agent is mobile safari" do
    request.user_agent = "Mozilla/5.0 (iPad; U; CPU OS 4_3 like Mac OS X; de-de) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8F191 Safari/6533.18.5"
    get :index
    request.format.should == :mobile
  end

  it "should use mobile format when user-agent is android" do
    request.user_agent = "Mozilla/5.0 (Linux; U; Android 2.2; en-us; Nexus One Build/FRF91) "
    get :index
    request.format.should == :mobile
  end
end