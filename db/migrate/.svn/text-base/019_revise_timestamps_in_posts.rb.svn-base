class ReviseTimestampsInPosts < ActiveRecord::Migration
  def self.up
    change_column :posts, :created_at, :timestamp
    change_column :posts, :updated_at, :timestamp
  end

  def self.down
    change_column :posts, :created_at, :date
    change_column :posts, :updated_at, :date
  end
end
