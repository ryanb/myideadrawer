require File.dirname(__FILE__) + '/../spec_helper'

describe Palette do
  it "should be valid" do
    Palette.new.should be_valid
  end
end
