class AddPublishDateToPostsAndMedia < ActiveRecord::Migration
  
  def self.up
    add_column :posts,  :published_at, :datetime
    add_column :medias, :published_at, :datetime
    
    Post.find(:all).each do |p|
      p.update_attribute(:published_at, p.updated_at) if p.status == "Published"
    end
    
    Media.find(:all).each do |m|
      m.update_attribute(:published_at, m.updated_at) if m.status == "Published"
    end
    
  end

  def self.down
    remove_column :posts,  :published_at
    remove_column :posts,  :published_at
  end
  
end
