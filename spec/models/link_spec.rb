require File.dirname(__FILE__) + '/../spec_helper'

describe Link do
  it "should be valid" do
    Link.new.should be_valid
  end
end
