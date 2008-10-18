class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :name
      t.integer :project_id
      t.string :url
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :links
  end
end
