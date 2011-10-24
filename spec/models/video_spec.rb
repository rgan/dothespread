require 'spec_helper'

describe Video do
    it "should require title" do
      Video.new("","", "keywords").valid?.should be_false
    end

    it "should require keywords" do
      Video.new("title","", "").valid?.should be_false
    end

    it "should be valid" do
      video = Video.new("title", "", "keywords")
      video.valid?.should be_true
    end
end