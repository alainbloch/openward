class RefreshAgainMediaAndPosts < ActiveRecord::Migration
  def self.up
    Media.find(:all).each {|m| m.save}
    Post.find(:all).each {|p| p.save}
  end

  def self.down
  end
end
