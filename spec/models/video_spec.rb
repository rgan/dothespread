require 'spec_helper'

describe Video do
    it "should require title" do
      Video.new.valid?.should be_false
    end
end