class RevisePages < ActiveRecord::Migration
  def self.up
    add_column :pages, :quote, :text
    add_column :pages, :quote_author, :string
    add_column :pages, :media_id, :integer
    add_column :pages, :quote_source, :string
  end

  def self.down
    remove_column :pages, :quote
    remove_column :pages, :quote_author
    remove_column :pages, :media_id
    remove_column :pages, :quote_source
  end
end
