class AddTokenToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :token, :string
  end

  def self.down
    remove_column :projects, :token
  end
end
