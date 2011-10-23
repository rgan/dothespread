require 'spec_helper'

describe Video do
    it "should require title" do
      Video.new("","").valid?.should be_false
    end

    it "should be valid" do
      video = Video.new("title", "")
      video.valid?.should be_true
    end
end