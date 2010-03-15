class AddCountsToPostsAndMedia < ActiveRecord::Migration
  def self.up
    add_column :posts, :visits_count, :integer
    add_column :posts, :comments_count, :integer
    add_column :medias, :visits_count, :integer    
  end

  def self.down
    remove_column :posts, :visits_count
    remove_column :posts, :comments_count 
    remove_column :medias, :visits_count 
  end
end
