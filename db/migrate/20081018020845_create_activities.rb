class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :message
      t.integer :project_id
      t.integer :user_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :activities
  end
end
