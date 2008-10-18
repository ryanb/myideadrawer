class CreateColorSwatches < ActiveRecord::Migration
  def self.up
    create_table :color_swatches do |t|
      t.integer :palette_id
      t.string :hex
      t.timestamps
    end
  end
  
  def self.down
    drop_table :color_swatches
  end
end
