class CreateIssues < ActiveRecord::Migration
  def self.up
    create_table :issues do |t|
      t.string :title
      t.text :intro
      t.integer :volume_id
      t.date :start_date, :end_date
      t.timestamps
    end
  end

  def self.down
    drop_table :issues
  end
end
