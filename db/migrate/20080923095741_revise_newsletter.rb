class ReviseNewsletter < ActiveRecord::Migration
  def self.up
=begin
    change_table :newsletters do |t|
      t.belongs_to :issue
      t.string :title
      t.text :intro
      t.timestamps
    end
=end    
    add_column :newsletters, :issue_id, :integer
    add_column :newsletters, :title, :string
    add_column :newsletters, :intro, :text
    add_column :newsletters, :created_at, :datetime
    add_column :newsletters, :updated_at, :datetime
  end

  def self.down
    change_table :newsletters do |t|
      t.remove :title, :intro, :issue_id
    end  
  end
  
end

