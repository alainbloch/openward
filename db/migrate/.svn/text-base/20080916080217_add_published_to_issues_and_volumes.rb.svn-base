class AddPublishedToIssuesAndVolumes < ActiveRecord::Migration
  def self.up
    add_column :issues, :published, :boolean, :default => false
    add_column :volumes, :published, :boolean, :default => false
  end

  def self.down
    remove_column :issues, :published 
    remove_column :volumes, :published 
  end
end
