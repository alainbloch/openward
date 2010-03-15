class ReviseComments < ActiveRecord::Migration
  def self.up
    rename_column :comments, :user_id, :owner_id
    add_column :comments, :owner_type, :string
    add_column :comments, :show, :boolean
    add_column :comments, :archived, :boolean
  end

  def self.down
    rename_column :comments, :owner_id, :user_id
    remove_column :comments, :owner_type
    remove_column :comments, :archived
    remove_column :comments, :show    
  end
end
