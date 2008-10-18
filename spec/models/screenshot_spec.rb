require File.dirname(__FILE__) + '/../spec_helper'

describe Screenshot do
  it "should be valid" do
    Screenshot.new.should be_valid
  end
end
