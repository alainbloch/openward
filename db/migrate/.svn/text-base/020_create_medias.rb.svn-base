class CreateMedias < ActiveRecord::Migration
  def self.up
    create_table :medias do |t|
      t.column :title,      :string
      t.column :url,        :string
      t.column :embed,      :string
      t.column :content,    :text
      t.column :excerpt,    :text
      t.column :created_at, :timestamp
      t.column :updated_at, :timestamp
      t.column :user_id,    :integer
      t.column :status,     :string,  :default => "Pending Review"
      t.column :file,       :string
      t.column :media_type, :string
      t.column :media_class, :string
      t.column :in_newsletter, :boolean, :default => 0
    end
  end

  def self.down
    drop_table :medias
  end
end
