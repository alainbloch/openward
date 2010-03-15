class RevisePostContent < ActiveRecord::Migration
  def self.up
    Post.find(:all).each do |post|
      post.content = post.content.gsub(/"(..\/)+/, '"/')
      post.save
    end
  end

  def self.down
  end
end