require 'spec_helper'


describe Location do

  it "should parse location from json" do
    location = Location.from_json('{"status": "OK","results": [ {"geometry": {"location": {"lat": 37.42,"lng": -122.1 } }} ]}')
    location.latitude.should == 37.42
    location.longitude.should == -122.1
  end

end