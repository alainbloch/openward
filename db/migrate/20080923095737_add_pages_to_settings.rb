class AddPagesToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :subscribe_page_id,  :integer
    add_column :settings, :connection_page_id, :integer
    add_column :settings, :archive_page_id,    :integer
  end

  def self.down
    remove_column :settings, :subscribe_page 
    remove_column :settings, :connection_page 
    remove_column :settings, :archive_page
  end
end
