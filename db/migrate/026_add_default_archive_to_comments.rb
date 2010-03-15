class AddDefaultArchiveToComments < ActiveRecord::Migration
  def self.up
    change_column_default :comments, :archived, false
  end

  def self.down
  end
end
