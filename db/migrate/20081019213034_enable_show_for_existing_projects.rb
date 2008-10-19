class EnableShowForExistingProjects < ActiveRecord::Migration
  def self.up
    Project.update_all ["show_code_snippets=?, show_palettes=?, show_links=?, show_notes=?, show_photos=?, show_screenshots=?", *([true]*6)]
  end

  def self.down
  end
end
