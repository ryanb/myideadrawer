class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :users, :openid_url
    add_index :projects, :user_id
    add_index :projects, :token
    add_index :color_swatches, :palette_id
    add_index :activities, :user_id
    %w[code_snippets palettes links notes photos screenshots activities].each do |table|
      add_index table, :project_id
    end
  end

  def self.down
    remove_index :users, :openid_url
    remove_index :projects, :user_id
    remove_index :projects, :token
    remove_index :color_swatches, :palette_id
    remove_index :activities, :user_id
    %w[code_snippets palettes links notes photos screenshots activities].each do |table|
      remove_index table, :project_id
    end
  end
end
