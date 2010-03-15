class JoinMediasTags < ActiveRecord::Migration
  def self.up
    
    create_table "medias_tags" do |t|
      t.column :media_id, :integer
      t.column :tag_id,   :integer
    end
    
  end

  def self.down
    drop_table "medias_tags"
  end
end
