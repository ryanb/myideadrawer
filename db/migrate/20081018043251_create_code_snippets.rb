class CreateCodeSnippets < ActiveRecord::Migration
  def self.up
    create_table :code_snippets do |t|
      t.integer :project_id
      t.string :name
      t.text :content
      t.string :language
      t.timestamps
    end
  end
  
  def self.down
    drop_table :code_snippets
  end
end
