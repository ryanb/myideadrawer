require File.dirname(__FILE__) + '/../spec_helper'

describe Activity do
  it "should be valid" do
    Activity.new.should be_valid
  end
end
