require File.dirname(__FILE__) + '/../spec_helper'

describe Palette do
  it "should be valid" do
    Palette.new.should be_valid
  end
  
  it "should have color hex getter/seter method" do
    palette = Palette.new(:color_hex_1 => 'foo', :color_hex_5 => 'bar')
    palette.color_hex_1.should == 'foo'
    palette.color_hex_5.should == 'bar'
  end
  
  it "should save color swatch on create" do
    palette = Palette.create!(:color_hex_2 => 'foo', :color_hex_4 => 'bar')
    palette.color_swatches(true).should have(2).records
  end
  
  it "should update or create existing color swatches" do
    palette = Palette.create!(:color_hex_2 => 'foo', :color_hex_4 => 'bar')
    palette.color_hex_1 = 'red'
    palette.color_hex_2 = 'green'
    palette.color_hex_3 = 'blue'
    palette.save
    palette.color_swatches(true).map(&:hex).should == %w[red green blue]
  end
  
  it "should destroy color hexes which aren't mentioned" do
    palette = Palette.create!(:color_hex_1 => 'foo', :color_hex_3 => 'bar')
    palette.color_hex_1 = 'red'
    palette.save
    palette.color_swatches(true).map(&:hex).should == %w[red]
  end
end
