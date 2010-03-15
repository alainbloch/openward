class JoinMediasPosts < ActiveRecord::Migration
  def self.up
    create_table :medias_posts do |t|
      t.integer :media_id, :post_id
    end
  end

  def self.down
    drop_table :medias_posts
  end
end
