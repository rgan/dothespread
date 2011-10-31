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

  it "should use mobile format when mobile is true" do
    get :index, {:mobile => true}
    request.format.should == :mobile
  end

end