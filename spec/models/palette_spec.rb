require File.dirname(__FILE__) + '/../spec_helper'

describe Palette do
  it "should be valid from factory" do
    Factory.build(:palette).should be_valid
  end
  
  it "should require name" do
    Factory.build(:palette, :name => '').should have(1).error_on(:name)
  end
  
  it "should have color hex getter/seter method" do
    palette = Factory.build(:palette, :color_hex_1 => 'foo', :color_hex_5 => 'bar')
    palette.color_hex_1.should == 'foo'
    palette.color_hex_5.should == 'bar'
  end
  
  it "should save color swatch on create" do
    palette = Factory(:palette, :color_hex_2 => 'foo', :color_hex_4 => 'bar')
    palette.color_swatches(true).should have(2).records
  end
  
  it "should update or create existing color swatches" do
    palette = Factory(:palette, :color_hex_2 => 'foo', :color_hex_4 => 'bar')
    palette.color_hex_1 = 'red'
    palette.color_hex_2 = 'green'
    palette.color_hex_3 = 'blue'
    palette.save
    palette.color_swatches(true).map(&:hex).should == %w[red green blue]
  end
  
  it "should destroy color hexes which aren't mentioned" do
    palette = Factory(:palette, :color_hex_1 => 'foo', :color_hex_3 => 'bar')
    palette.color_hex_1 = 'red'
    palette.save
    palette.color_swatches(true).map(&:hex).should == %w[red]
  end
  
  it "should remember color hexes across reload (get from color swatch)" do
    palette = Factory(:palette, :color_hex_1 => 'foo', :color_hex_5 => 'bar')
    palette.reload
    palette.color_hex_1.should == 'foo'
    palette.color_hex_2.should == 'bar'
  end
  
  it "should not clear color hexes when saving without updating colors" do
    palette = Factory(:palette, :color_hex_1 => 'foo', :color_hex_5 => 'bar')
    palette.save
    palette.color_hex_1.should == 'foo'
    palette.color_hex_2.should == 'bar'
  end
end
