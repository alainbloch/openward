class AddSourceUrlToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :source, :text
  end

  def self.down
    remove_column :posts, :source
  end
end
