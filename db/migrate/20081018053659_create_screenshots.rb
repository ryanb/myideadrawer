class CreateScreenshots < ActiveRecord::Migration
  def self.up
    create_table :screenshots do |t|
      t.string :name
      t.integer :project_id
      t.string :source_url
      t.timestamps
    end
  end
  
  def self.down
    drop_table :screenshots
  end
end
