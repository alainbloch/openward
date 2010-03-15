class RenameUrlToUriInPages < ActiveRecord::Migration
  def self.up
    rename_column :pages, :url, :uri
  end

  def self.down
    rename_column :pages, :uri, :url
  end
end
