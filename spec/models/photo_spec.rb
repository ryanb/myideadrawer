require File.dirname(__FILE__) + '/../spec_helper'

describe Photo do
  it "should be valid" do
    Photo.new.should be_valid
  end
end
