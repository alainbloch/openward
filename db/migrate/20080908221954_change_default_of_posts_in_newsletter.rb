class ChangeDefaultOfPostsInNewsletter < ActiveRecord::Migration
  def self.up
    change_column_default :posts, :in_newsletter, true
  end

  def self.down
    change_column_default :posts, :in_newsletter, false
  end
end
