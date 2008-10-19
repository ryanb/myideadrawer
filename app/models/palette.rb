class Palette < ActiveRecord::Base
  include ProjectItem
  
  belongs_to :project
  has_many :color_swatches
  
  after_save :save_color_swatches
  
  validates_presence_of :name
  
  def to_s
    name
  end
  
  private
  
  def color_hexes
    @color_hexes ||= Hash.new
  end
  
  def method_missing(name_sym, *args, &block)
    case name_sym.to_s
    when /^color_hex_([0-9])+$/
      color_hexes[$1.to_i] || (color_swatches[$1.to_i-1] && color_swatches[$1.to_i-1].hex)
    when /^color_hex_([0-9])+=$/
      color_hexes[$1.to_i] = args.first
    else
      super
    end
  end
  
  # updates existing color swatches and destroys leftovers
  def save_color_swatches
    unless color_hexes.empty?
      color_swatches.each { |c| c.hex = nil }
      color_hexes.keys.sort.each_with_index do |key, index|
        swatch = color_swatches[index] || color_swatches.build
        swatch.update_attribute(:hex, color_hexes[key])
      end
      color_swatches.each { |c| c.destroy if c.hex.blank? }
      @color_hexes = nil
    end
  end
end
