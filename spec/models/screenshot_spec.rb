require File.dirname(__FILE__) + '/../spec_helper'

describe Screenshot do
  it "should be valid from factory" do
    Factory.build(:screenshot).should be_valid
  end
  
  it "should require name" do
    Factory.build(:screenshot, :name => '').should have(1).error_on(:name)
  end
  
  it "should use thumbalizr for image url" do
    APP_CONFIG['thumbalizr_key'] = 'key'
    screenshot = Screenshot.new(:source_url => 'railscasts.com')
    screenshot.image_url(250).should == "http://api.thumbalizr.com?api_key=key&url=railscasts.com&width=250"
  end
  
  it "should automatically add protocol to source url" do
    screenshot = Factory(:screenshot, :source_url => 'example.com')
    screenshot.source_url.should == 'http://example.com'
  end
end
