class RemoveIdsFromJoins < ActiveRecord::Migration
  def self.up
    remove_column :posts_tags, :id
    remove_column :medias_tags, :id
    remove_column :medias_posts, :id
  end

  def self.down
    add_column :posts_tags, :id, :integer
    add_column :medias_tags, :id, :integer
    add_column :medias_posts, :id, :integer
  end
end
