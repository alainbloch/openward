class AddUriToMedias < ActiveRecord::Migration
  def self.up
    add_column :medias, :uri, :string
    
    Media.find(:all).each do |m|
      m.save
    end
    
  end

  def self.down
    rename_column :medias, :uri
  end
end
