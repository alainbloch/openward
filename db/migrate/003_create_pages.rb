class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.column :title,      :string
      t.column :url,        :string
      t.column :content,    :text
      t.column :created_at, :date
      t.column :updated_at, :date
      t.column :active,     :boolean
      t.column :user_id, :integer
    end
  end

  def self.down
    drop_table :pages
  end
end
