class CreateVisitors < ActiveRecord::Migration
  def self.up
    create_table :visitors do |t|
      t.column :ip, :string
      t.column :name, :string
      t.column :email, :string
      t.column :website, :string
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :visitors
  end
end
