class AddUserAsOwnerOfUserPosts < ActiveRecord::Migration
  def self.up
    User.find(:all).each do |user|
      user.posts.each do |post|
        post.accepts_role("owner", user)
      end
      user.medias.each do |media|
        media.accepts_role("owner", user)
      end
    end
  end

  def self.down
  end
end
