class AddIndexesForPostsAndMediasCounterCaches < ActiveRecord::Migration
  def self.up
    add_index :posts, :comments_count, :name => "index_comments_count_on_posts"
    add_index :posts, :visits_count, :name => "index_visits_count_on_posts"
    add_index :medias, :visits_count, :name => "index_visits_count_on_medias"
  end

  def self.down
    remove_index :posts, :comments_count, :name => "index_comments_count_on_posts"
    remove_index :posts, :visits_count, :name => "index_visits_count_on_posts"
    remove_index :medias, :visits_count, :name => "index_visits_count_on_medias"    
  end
end
