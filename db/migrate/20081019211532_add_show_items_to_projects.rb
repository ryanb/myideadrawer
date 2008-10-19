class AddShowItemsToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :show_code_snippets, :boolean
    add_column :projects, :show_palettes, :boolean
    add_column :projects, :show_links, :boolean
    add_column :projects, :show_notes, :boolean
    add_column :projects, :show_photos, :boolean
    add_column :projects, :show_screenshots, :boolean
  end

  def self.down
    remove_column :projects, :show_screenshots
    remove_column :projects, :show_photos
    remove_column :projects, :show_notes
    remove_column :projects, :show_links
    remove_column :projects, :show_palettes
    remove_column :projects, :show_code_snippets
  end
end
