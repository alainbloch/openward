class ReviseOwnerToCommentator < ActiveRecord::Migration
  def self.up
    rename_column :comments, :owner_id, :commentator_id
    rename_column :comments, :owner_type, :commentator_type
  end

  def self.down
    rename_column :comments, :commentator_id, :owner_id
    rename_column :comments, :commentator_type, :owner_type
  end
end
