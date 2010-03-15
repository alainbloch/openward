class AddInitialCountToPostsAndMediaTables < ActiveRecord::Migration
  def self.up
    
    Post.find(:all).each do |post|
      post.update_attribute(:comments_count, post.comments.size)
      post.update_attribute(:visits_count, post.visits.size)
    end
    
    Media.find(:all).each do |media|
      media.update_attribute(:visits_count, media.visits.size)
    end
    
  end

  def self.down
  end
end
