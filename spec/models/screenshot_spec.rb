require File.dirname(__FILE__) + '/../spec_helper'

describe Screenshot do
  it "should be valid" do
    Screenshot.new.should be_valid
  end
  
  it "should use thumbalizr for image url" do
    APP_CONFIG['thumbalizr_key'] = 'key'
    screenshot = Screenshot.new(:source_url => 'railscasts.com')
    screenshot.image_url(250).should == "http://api.thumbalizr.com?api_key=key&url=railscasts.com&width=250"
  end
end
