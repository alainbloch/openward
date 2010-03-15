class AddActiveToIssuesAndVolumes < ActiveRecord::Migration
  def self.up
    add_column :volumes, :active, :boolean, :default => false
    add_column :issues,  :active, :boolean, :default => false
  end

  def self.down
    remove_column :volumes, :active
    remove_column :issues,  :active
  end
end
