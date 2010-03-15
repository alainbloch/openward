class AddStatusToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :status, :string, :default => Page::STATUS[0]
    remove_column :pages, :active
  end

  def self.down
    remove_column :pages, :status
    add_column :pages, :active, :boolean, :default => 0
  end
end
