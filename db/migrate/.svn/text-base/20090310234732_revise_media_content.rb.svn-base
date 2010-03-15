class ReviseMediaContent < ActiveRecord::Migration
  def self.up
    Media.find(:all).each do |media|
      media.content = media.content.gsub(/"(..\/)+/, '"/')
      media.save
    end
  end

  def self.down
  end
end
