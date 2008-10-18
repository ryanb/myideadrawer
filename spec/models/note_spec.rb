require File.dirname(__FILE__) + '/../spec_helper'

describe Note do
  it "should be valid" do
    Note.new.should be_valid
  end
end
