class CreateAssociations < ActiveRecord::Migration
  def self.up
    create_table :associations do |t|
      t.integer :media_id, :post_id
      t.timestamps
    end
  end

  def self.down
    drop_table :associations
  end
end
