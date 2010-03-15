class JoinPostsTags < ActiveRecord::Migration
  def self.up
    
    create_table "posts_tags" do |t|
      t.column :post_id, :integer
      t.column :tag_id, :integer
    end
    
  end

  def self.down
    drop_table "posts_tags"
  end
  
end
