class RefreshMediaAndPosts < ActiveRecord::Migration
  def self.up
    v = Volume.find(:first).update_attribute(:active, true)
    Media.find(:all).each {|m| m.save}
    Post.find(:all).each {|p| p.save}
  end

  def self.down
  end
end
